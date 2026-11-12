# Style: tilt-shift voxel diorama

Still voxel: everything is built from scaled cubes, exactly like `voxel.md`. What changes is the camera and the subject. The camera sits high and far away with a narrow lens, and a tilt-shift blur keeps only a horizontal band in focus. Together with boosted saturation, that makes a whole city read as a miniature model on a table. Used by `wow-cities/` (WoW Forever Cities). **Reference implementation: `wow-cities/stormwind.html`.**

## The quality bar

- **A city you'd recognize from the air.** 4 to 6 landmark structures in their real arrangement (Stormwind: the walls and gate, the keep on its terrace, the cathedral and its spire, the canal, the Valley of Heroes statues). Generic houses fill in around them, but landmarks come first.
- **It's alive and it loops forever.** 30 to 45 tiny citizens walk a node graph, stop at shops and doors, and chat. Guards patrol fixed routes or stand at the gate, riders trot by, and flying mounts circle and land at the flight master. There's at least one city machine running on a cycle (ships, zeppelins, lifts, a lava pour).
- **At least 4 ambient motions:** water waves, smoke from chimneys, fire flicker, flags, fountains, falling leaves or snow, wisps, birds, clouds.
- **Miniature scale.** People are about 1.4 units tall, built from 15 to 25 boxes, and race reads from silhouette (tusks, horns, ears, beards, hunch). Buildings are 3 to 14 units tall. Nothing is huge next to its neighbours unless it is huge in the game.
- **Day/night** for open-air cities: a cycle of about 150 seconds where windows and lamps glow at night. Underground and magical cities (Ironforge, Undercity, Darnassus) use fixed light.
- **No HUD, no text at all.** A city has no unit frame, ability names or nameplates.

## Tech

Same as `voxel.md` (one HTML file, three.js **0.160.0** importmap, fixed 60 Hz `tick`, per-frame `animate`, one InstancedMesh for static props). The differences:

- Camera: FOV 30, start at `(0,56,70)` (override with `CFG.cam`), orbit target `(0,CFG.ty??3,0)`, autoRotate 0.22, polar angle between 0.35 and 1.18, no pan.
- Post: `RenderPass` → `UnrealBloomPass(.5,.5,.86)` → `OutputPass` → grade (saturation ~1.25, contrast, vignette) → **two separable tilt-shift blur passes**, horizontal plus vertical, run twice. The blur is 0 inside the focus band at `focus=.47 ± .09` of screen height and grows to full strength about 0.3 screens below it. Above the band the blur starts later and only reaches about half strength, so the far side of the city stays readable (the user found full-strength top blur too much).
- Lit windows and lamp heads go into a **second InstancedMesh** that shares `winMat`. Its colour is scaled from 0.3 (by day) to 3 (by night) so they bloom only after dark. Lamp point lights are created once, and only their intensity changes.
- People: `walker(model,node,{route|talk|stand})` on a `node()`/`link()` graph. A node can have `stop:[min,max]` (shops and doors) and `look` (which way to face while stopped). Lane offsets keep crowds from walking single file.
- Flights: `flight(model, points, {roost})` loops a closed Catmull-Rom curve. With a roost, it lands along a cubic Bézier, rests with its wings folded, and takes off again.
- `lift(group,y0,y1)` for elevators, `field(n,mat,fn)` for instanced particles whose positions are a pure function of time (fountains, snow, lava, leaves).

The cities are generated from a shared kernel kept outside the repo, so every city file has the same helpers. To change a city, edit its HTML directly.

## Known pitfalls

- Nav edges must stay clear of buildings and water. A walker goes in a straight line between linked nodes, so check every edge against the footprint of each house row.
- Nodes on bridges, terraces and decks need an explicit `y`, because `groundAt` reports the canal bed or the cliff below.
- Keep every building inside the walls' inner radius and off the patrol ring.
- Tall landmarks near the front of the island hide the city as the camera orbits. Put them on the back half or keep them slim.
- `terrain()` columns are at least 2 units tall, so a deep pit (Undercity) doesn't produce negative-scale, inside-out boxes. Keep it that way.
- The kernel already owns short global names (`LT` is the light state; also `R`, `B`, `G`, `V`). A city that declares one again fails silently with a blank sky-coloured page, so check `node --check` and the console when a render comes back empty.
- Give each city its real geography, not a generic ring of buildings: Stormwind's canals and districts, Orgrimmar's valleys carved into a mesa. Choose `CFG.cam` so the signature feature sits in the focus band.
- Heavy post (6 passes) makes headless renders slow, so give `sim.sh` and `shot.sh` generous time budgets.

## Verify before calling it done

1. `tools/sim.sh <file> "<expr>"`: no `UNCAUGHT` errors, most walkers moving, and no walker that stays frozen (compare positions between reports). Flyers cycle through `loop → land → rest → up`.
2. `tools/shot.sh` at the default camera, and (for cities with a day/night cycle) with `PATCH="T0=CFG.t0??.15;=>T0=.7;"` for night.
3. Close-ups with `TGT="x,y,z" CAM="x,y,z"` on each landmark, a crowd, a guard and a flyer. Look for walkers inside walls, floating props and z-fighting.
