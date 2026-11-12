# Style: voxel

Stylized three.js scenes built entirely from scaled cubes, on a small floating island, with bloom-lit spell effects. Used by `wow/` (WoW Forever Classes). **Reference implementation: `wow/warrior.html`** (cleanest). Every scene in `wow/` meets this bar.

## The quality bar

A voxel scene is done when all of this is true:

- **A zone you'd recognize from a screenshot.** One clear palette and 4 to 6 *signature* props (a moonwell, a spiked palisade, troll ruins, tipis and totems). No generic filler. Rim hills frame the play area.
- **At least 3 ambient motions** that run whether or not anything is fighting: water waves + foam, plus two of drifting clouds, flickering fire with embers, falling snow/leaves/dust, wisps, birds, swaying grass, mist.
- **Characters with a silhouette.** About 2.6 units tall, built from 30 to 60 boxes: head with face details (eyes, tusks, ears, hood), shoulders wider than the waist, belt, a real weapon. Legs pivot at the hip and arms at the shoulder. Races and creatures should read at a glance from the default camera.
- **Every ability has its own effect**, never just a number. Use the effect vocabulary below. Two abilities should not look the same.
- **Every hit lands.** The target flashes red, squashes and knocks back, sparks burst, and big hits shake the camera. Deaths shatter the model into its own voxels.
- **Motion has anticipation and follow-through.** Swings wind up, snap through, and recover. Casters raise their hands, channels hold a pose, and sitting to eat actually sits.
- **The behavior loops forever** and covers the interesting cases within about 30 seconds: pull, rotation, a defensive or emergency, then downtime (eat/drink), then the next pull somewhere else.
- **Nothing clips.** Melee stops at a body length. Long creatures (cats, wolves) need more room. Mobs push apart from each other and from the player.

## Tech

- One HTML file, one ES module, three.js **0.160.0** from the jsdelivr importmap (`three` + `three/addons/`). No other libraries and no image files.
- A fixed **60 Hz simulation** (`tick(dt)`) is kept separate from per-frame visuals (`animate(dt,t)`). AI and combat go in tick; anything that only looks a certain way goes in animate.
- Camera: `OrbitControls`, damped, slow `autoRotate` (0.35), polar angle capped at 1.3, FOV 45, start at `(0,22,30)`. The target follows the player and leans toward the enemy.
- Post: `EffectComposer` → `RenderPass` → `UnrealBloomPass(.55,.45,.86)` → `OutputPass`. ACES tone mapping at about 0.85 (night zones up to 1.0). The bloom threshold is set so **only glow materials bloom**, never Lambert surfaces.
- Lights: a hemisphere light plus one shadow-casting directional light (2048 map). Use **one** reusable PointLight for spell flashes; never add or remove lights at runtime (shader recompiles cause stutter). Static point lights for fires and lamps are created once.
- Static props are baked into **one InstancedMesh** (`prop(...)` list). Particle fields (snow, leaves, dust, grass) are instanced meshes updated in place.

## Construction helpers

`B(parent,sx,sy,sz,color,x,y,z,mat)` places one scaled box, and `G(parent,x,y,z)` makes a pivot group. Each character gets its own material set (`ms()`) so it can flash. Glow parts use `glow(color)`, an HDR basic material that blooms. **Pass it a mid or dark color**, because it multiplies by 3, so light colors blow out to white.

## Effect vocabulary

Glow-voxel particles; additive rings expanding on the ground; light columns (open cylinders); jagged lightning (`bolt`); projectiles with glow trails; voxel-tile ground effects (Consecration, Blizzard); wireframe icosphere shields; orbiting stars for stuns; purple wisps for fear; dripping red for bleeds; DoT particles in the DoT's color; combo points as glowing cubes orbiting above the target.

## On-screen UI (and nothing else)

- **Instant abilities:** the name pops above the caster in Cinzel, in the ability's color, then floats up and fades.
- **Cast-time and channeled abilities:** the **cast bar only**. Never also pop a name when the cast finishes.
- Damage and heal numbers, small nameplates over mobs, and a top-left unit frame: portrait, name, HP and resource bars *with numbers* (mana blue, rage red, energy yellow), with a thin pet bar under it if there's a pet. No buff list.
- No titles, zone labels, captions, legends or explanations. See "No AI slop" in `CLAUDE.md`.

## Known pitfalls (all of these have happened)

- `mesh.scale.setScalar(1+pulse)` on a box made with `B()` **overwrites** its size and turns a 0.2 orb into a 1×1 glowing block. Multiply the base size instead.
- AI that cancels a channel ("break Blizzard when they reach me") must only cancel that specific channel, and only when it can afford the answer. Otherwise it cancels the wand forever and the character freezes.
- Every resource path needs a fallback: casters out of mana in combat **wand**. Nobody should ever just stand still.
- Cooldown checks like `!(cd>0)` are true when the ability is off cooldown but unaffordable. Check mana too.
- Timers stored as numbers go negative; `!m.stun` is false for `-0.5`. Compare with `<= 0`.
- A prop placed inside the play area will block the camera. Keep tall props on the rim.
- Bows, staves and weapons hang off a hand group. Check them from the side in the pose they're actually used in.

## Verify before calling it done

Screenshots at the default camera angle are not enough to catch these. For every new or changed scene:

1. `tools/sim.sh <file> "<state expr>"` runs about 60 simulated seconds and prints state every 3s. Confirm it loops through several pulls, every ability fires, and there are no `UNCAUGHT` errors.
2. Force the edge cases in the sim expression (for example, pin mana to 0 while in combat) and confirm nothing stalls.
3. `tools/shot.sh <file> out.png` at the default camera, **and** `CAM="0,7,11"` for a close-up of the character. Add `PRE=<frames>` (20 per simulated second) to shoot mid-fight: AoE channels, procs, the second spec. Look at every glowing thing and every held item. If something looks off, find out why before moving on.
