# WoW Forever Classes

Voxel three.js animations of **WoW Forever** class rotations and leveling gameplay. Each class plays its rotation on loop on a small island in a zone that fits the class. Everything is coded by agents: one self-contained HTML file per class, with no build step and no image assets.

The rotations follow the classic-era (1.12-style) ability kits as played on WoW Forever. They are made for watching, not min-maxing. Cooldowns, damage, and HP are compressed so the interesting parts (pulls, procs, emergencies, downtime) all show up within about 30 seconds.

**Style: voxel.** See `../styles/voxel.md` for the quality bar, tech, pitfalls and how to verify; `../CLAUDE.md` for repo rules.

## Files

| File | What it is |
|---|---|
| `index.html` | Class picker: the scene fills the screen, class buttons sit in a small bar at the bottom. Deep-link with `#warrior`, `#paladin`, `#hunter`, etc. |
| `warrior.html` | Arms Warrior in **Durotar**, charging a linked Quilboar pair |
| `paladin.html` | Retribution Paladin in **Elwynn Forest**, pulling a 2-gnoll camp |
| `hunter.html` | Beast Mastery Hunter in **Teldrassil**, nightsaber tanking a Furbolg pair |
| `rogue.html` | Combat Rogue in **Stranglethorn Vale**, stealth opener on a linked troll pair |
| `priest.html` | Shadow Priest in **Duskwood** at night, a Nightbane worgen pair |
| `shaman.html` | Shaman in **Dun Morogh**, alternating specs every pull (starts Enhancement): Enhancement vs a solo Wendigo / Ice Claw Bear, Elemental vs a pack of 3 (Frostmane trolls / Rockjaw troggs) |
| `mage.html` | Frost Mage in **Westfall**, AoE-pulling a pack of 4 Harvest Watchers |
| `warlock.html` | Affliction Warlock in **Tirisfal Glades**, multi-DoTing 2 ghouls with a Voidwalker tank |
| `druid.html` | Druid (tauren) in **Mulgore**, alternating specs every pull (starts Feral): Feral (cat) stealth opener on a solo beast, Balance (Moonkin) vs a pack of 3 |

Open `index.html` directly in a browser. No server needed.

To change a class, edit its HTML file directly. To add one, copy a scene (`warrior.html` is the cleanest template) and add `{id,name,color,file}` to the `CLASSES` array in `index.html`.

---

## Rotations

### Paladin: Retribution, 2-mob pull (Elwynn Forest)
The classic Ret leveling loop: pull two linked mobs, AoE them down, use your defensive cooldowns, then sit down and drink.

1. **Out of combat:** Retribution Aura, Blessing of Might, Seal of Righteousness.
2. **Pull:** walk to about 9 yards and cast **Judgement**. A golden hammer drops on the first gnoll. Its camp-mate **links** (social aggro) and both run in.
3. **Re-seal:** Seal of Command while they close the distance.
4. **Consecration** once both are in melee (tile disc, ticks every 1s on everything inside).
5. **Hammer of Justice** the *off-target* so you only take one mob's hits for 6s.
6. **Judgement** on cooldown, then re-seal (only while mana > ~20%). Judgement of Command does double damage to stunned targets.
7. **Auto-attack** a 2-hander on a 3.0s swing. Seal of Command procs a second holy hit (gold burst).
8. **Hammer of Wrath** (1s cast, thrown) to execute a target under 20%.
9. **Emergency:** under 35% HP, **Divine Shield**, then **Holy Light** inside the bubble. **Lay on Hands** is the last resort.
10. **Downtime:** Holy Light if hurt, then **Eat & Drink** until full. Next camp spawns elsewhere.

Retribution Aura reflects small holy damage whenever a gnoll hits you.

### Warrior: Arms, 2-mob pull (Durotar)
1. **Out of combat:** **Bloodrage** for rage, **Battle Shout**.
2. **Pull:** **Charge** (dust trail, stun, +rage). The second Quilboar links.
3. **Sweeping Strikes** and **Thunder Clap** (slows both) once both are in melee.
4. **Mortal Strike** on cooldown, **Rend** on fresh targets, **Overpower** after a dodge.
5. **Heroic Strike** queued on the next swing when rage is high (blade glows orange).
6. **Execute** under 20%. **Healing Potion** if HP gets low. Rage decays out of combat.
7. **Downtime:** eat.

### Hunter: Beast Mastery, pet tank (Teldrassil)
1. **Out of combat:** **Aspect of the Hawk**, **Mend Pet** if the nightsaber is hurt.
2. **Pull:** **Hunter's Mark**, **Aimed Shot** opener, then send the pet. The second Furbolg links and runs at the hunter.
3. **Bestial Wrath** on cooldown (pet grows and glows red).
4. **Multi-Shot** while both are up, **Serpent Sting**, **Aimed Shot** when nothing is on you, **Arcane Shot**, Auto Shot throughout.
5. **Pulled aggro:** pet **Growls** it off. While Growl is down, kite: **Concussive Shot**, back-pedal, turn and shoot, and **Wing Clip** if it catches up.
6. **Downtime:** drink.

### Rogue: Combat, 2-mob pull (Stranglethorn Vale)
1. **Sprint** toward the next pull, **Stealth**, sneak around behind the target.
2. **Cheap Shot** opener (stun, 2 combo points). Combo points orbit above the target.
3. **Adrenaline Rush** + **Blade Flurry** when both trolls are on you.
4. **Slice and Dice**, then **Sinister Strike** to 5 combo points and **Eviscerate**.
5. **Riposte** after a parry, **Evasion** when HP gets low.
6. **Downtime:** eat.

### Priest: Shadow, 2-mob pull (Duskwood)
1. **Out of combat:** **Shadowform**, **Inner Fire**.
2. **Pull:** **Power Word: Shield**, then **Mind Blast**. The second worgen links.
3. **Shadow Word: Pain** on both, **Vampiric Embrace** on the target.
4. **Psychic Scream** when both reach melee (they scatter in fear).
5. **Mind Blast** on cooldown, **Mind Flay** channel, wand (**Shoot**) to finish low targets.
6. **Downtime:** drink.

### Druid: Balance / Feral, alternating (Mulgore)
The druid starts Feral and swaps spec after every pull (a 2.5s spec cast, a burst of light, then the new spec's name and icon flash on screen). The unit frame always shows the current spec next to the name, and the portrait icon changes with it. Each spec gets its own kind of pull, and each pull is a different Mulgore mob.

**Balance, pack of 3** (Venture Co. workers, Bristleback quilboars, Adult plainstriders):
1. **Moonkin Form** (feathered owlbear, glowing aura ring).
2. **Starfire** pull (2.5s cast): a star falls from the sky onto the target, and the whole pack links.
3. **Entangling Roots** (1.5s cast) on the farthest runner: vines grow up its legs and hold it out of melee.
4. **Moonfire** (silver light column, DoT) on up to two mobs at a time; **Insect Swarm** (buzzing cloud, DoT) on the kill target.
5. Two in melee: **Barkskin** (bark plates orbit the druid), then **Hurricane** (6s channel: storm cloud, swirling wind and leaves, lightning, slows).
6. **Wrath** (green bolt) on whatever is in melee, Starfire when nothing is. **Innervate** when mana is low. Out of mana: claw it out in Moonkin Form.

**Feral, solo beast** (Prairie Wolf Alpha, Mountain Cougar, Elder Plainstrider):
1. **Cat Form**, **Dash** to close the distance, **Prowl**, circle behind, **Pounce** (leap, stun, bleed).
2. **Shred** while still behind the stunned target, then **Faerie Fire (Feral)**, **Rake**, **Claw** to build combo points, **Tiger's Fury** when energy is low.
3. **Omen of Clarity:** auto-attacks can proc **Clearcasting** (a white swirl), and the next ability is free.
4. Five combo points: **Rip** on a healthy target, otherwise **Ferocious Bite**.

**Both:** **Mark of the Wild** and **Thorns** in caster form; under 33% HP, shift out and cast **Regrowth**, then **Rejuvenation** and back into form. Downtime: Regrowth if hurt, then drink.

### Shaman: Elemental / Enhancement, alternating (Dun Morogh)
Starts Enhancement and swaps spec after every pull, the same way the druid does. The weapon swaps with it: a staff with a glowing crystal for Elemental, the 2H axe for Enhancement. **Ghost Wolf** between pulls in both specs.

**Elemental, pack of 3** (Frostmane Headhunters, Rockjaw Troggs):
1. **Searing Totem** at the pull spot, **Elemental Mastery** (fire and frost orbs circle the shaman, and the next spell is a guaranteed crit), then **Chain Lightning** (2s cast). The bolt jumps to all three mobs and the pack links.
2. Two in melee: **Fire Nova Totem**. Its core swells and flickers faster, then explodes in a fire ring 3s later.
3. Anything in melee: **Earthbind Totem** (pulses a dust ring that slows everything within 8 yards), then the shaman runs out of the field and goes back to casting while the pack crawls after it.
4. **Chain Lightning** on cooldown, **Flame Shock** on fresh targets, **Frost Shock** on whatever is in melee (ice shards, slowed), **Earth Shock** to finish low ones. The shocks share a cooldown.
5. **Lightning Bolt** filler from the staff, **Healing Wave** under 40%. Out of mana: melee with the staff.

**Enhancement, solo** (Wendigo, Ice Claw Bear):
1. **Out of combat:** Lightning Shield (3 orbiting charges), Windfury Weapon (blade glows).
2. **Travel:** **Ghost Wolf** (1s cast) to the next mob, drop out of wolf at about 14 yards.
3. **Pull:** **Lightning Bolt** (2.5s cast, jagged voxel bolt).
4. While it runs in: **Strength of Earth Totem** + **Searing Totem** (shoots fire bolts).
5. **Stormstrike** on cooldown: two sky-lightning hits, +20% to the next nature spell → **Earth Shock** while that buff is up.
6. **Flame Shock** when the DoT is down; Earth Shock to finish under 25%. Shocks share a cooldown.
7. **Windfury** procs (22%): two extra fast swings + wind rings. Lightning Shield zaps whatever hits you.
8. **Healing Wave** under 45% mid-fight; downtime: Healing Wave, eat & drink, re-shield.

The model is an orc shaman (dwarves can't be shamans in classic), placed in Dun Morogh.

### Warlock: Affliction, 2-mob pull (Tirisfal Glades)
1. **Out of combat:** Demon Armor, **Summon Voidwalker**.
2. **Pull:** send the Voidwalker in, **Corruption** on the first ghoul. The second one links.
3. Voidwalker **Torments** the first ghoul; the second comes to you.
4. **Corruption** + **Curse of Agony** on both (CoA ramps up), **Immolate** (2s cast, fire DoT). DoT pips show under the nameplates.
5. **Drain Life** the ghoul hitting you (drain-tank, red beam).
6. **Drain Soul** anything under 25% (purple beam) → **Soul Shard** flies back to you.
7. **Life Tap** for mana; **Death Coil** under 30% HP (heal + fear).
8. **Downtime:** Health Funnel the Voidwalker, Life Tap, eat & drink.

### Mage: Frost AoE, pack of 4 (Westfall)
1. **Out of combat:** Frost Armor, Arcane Intellect, **Ice Barrier** (absorb shield).
2. **Pull:** **Frostbolt** one Harvest Watcher; the whole pack comes.
3. **Blizzard** (8s channel) on the pack as it runs in: frost-tile disc, cloud, falling shards, chill.
4. When they reach you: **Frost Nova** (encased in ice) → walk out while they're frozen.
5. Next time: **Cone of Cold** → **Blink** out → **Blizzard** again.
6. **Arcane Explosion** spam to finish when everything is low and in melee. Frozen targets take extra crits (Shatter).
7. **Out of mana:** wand (**Shoot**) until the pack is down.
8. **Ice Block** under 25% HP. **Evocation** or eat & drink after.

---

## Zones and colors

### Zones (one per class)
| Zone | Palette |
|---|---|
| Elwynn Forest (Paladin) | sky `#a9d8f2`, grass HSL(.27,.55,.42±), oaks + pines, wildflowers, wooden fence, gnoll camp with tent |
| Dun Morogh (Shaman) | pale sky `#cfe2f0`, bluish snow HSL(.58,.28,.9), taller rocky snow-capped rim, snowy pines, dwarven lantern posts, icy water + floating floes, snowfall |
| Tirisfal Glades (Warlock) | overcast `#8a9590` + close fog, dead olive grass HSL(.19,.24,.36), dirt patches, bare voxel trees, graveyard, pumpkin patch, green-glow iron lamps, low drifting mist |
| Westfall (Mage) | warm sky `#b9d9ee`, golden-olive grass HSL(.15,.48,.42), plowed field rows, wheat, haystacks, turning windmill |
| Teldrassil (Hunter) | twilight sky `#2a3266`, teal grass HSL(.42,.42,.36), giant violet-bark trees with purple/teal canopies, glowing cyan mushrooms, moonwell with a light column, moonstone lanterns, wisps, falling violet leaves, moon |
| Durotar (Warrior) | dusty sky `#e9c9a2`, red dirt HSL(.05,.48,.5), striped red mesa rim, thorn bushes, dead trees, orc hut + spiked palisade, braziers, drifting dust, teal sea |
| Stranglethorn Vale (Rogue) | hazy sky `#bfdcc6`, jungle green HSL(.27,.55,.3), jungle trees with vines, palms, ferns, mossy troll ruins with a carved face, tiki torches, parrots, pollen, turquoise sea |
| Duskwood (Priest) | night sky `#1b2338` + close fog, dark grass HSL(.28,.3,.27), black pines, twisted trees, abandoned cottage with a lit window, Darkshire lamp posts, big moon, low mist, fireflies, bats |
| Mulgore (Druid) | clear sky `#bfe0f4`, plains HSL(.2,.5,.47), swaying instanced grass, tipis, painted totem poles, lone trees, a mesa in the sea, eagles |


### Ability colors used so far
Nature/lightning `#9fe8ff` · Windfury `#dff6ff` · Earth `#e8c46a`/`#9be27a` · Fire `#ff8a3a` · Shadow `#c69bff` · Curse of Agony `#ff7a4a` · Drain Life `#ff5a6a` · Fel/Siphon `#8aff6a` · Frost `#9fdcff`/`#bfe9ff` · Arcane `#f0a8ff` · Holy gold `#ffd86b`/`#ffe680` · Seal of Command `#ffd23f` · Blessing `#ffab6b` · Hammer of Justice `#8fd0ff` · Hammer of Wrath `#ffb13b` · Divine Shield `#fff6c8` · Eat & Drink `#8fd0ff` · Hunter's Mark `#ff5a4a` · Serpent Sting `#9be27a` · Arcane Shot `#ff9aff` · Aimed Shot `#ffe27a` · Concussive `#bfe6ff` · Bestial Wrath `#ff3a2a` · Immolate `#ff8a2a` · Rage/bleed `#ff5a4a` · Mortal Strike `#ff3a2a` · Battle Shout `#ff8a3a` · Energy/Slice and Dice `#ffe94a` · Blade Flurry `#ff8a6a` · Shadowform/Mind Flay `#b98aff`/`#c9a0ff` · Psychic Scream `#b06aff` · PW: Shield `#fff2b0` · Mark of the Wild `#e27aff` · Rejuv/Thorns `#9be27a` · Tiger's Fury `#ff7c0a` · Balance spec / Moonkin `#a8b8ff` · Starfire `#ffd98a` · Moonfire `#bcd0ff` · Wrath `#9be27a` · Insect Swarm `#b8e05a` · Entangling Roots `#6aa83a` · Hurricane `#bfe6ff` · Barkskin `#c8955a` · Innervate `#8fd0ff` · Clearcasting `#bfe6ff` · Dash `#ffd23f` · Shred `#ff6a5a` · Elemental spec `#7fd0ff` · Enhancement spec `#e8b04a` · Elemental Mastery `#ff9a4a` · Fire Nova `#ff6a2a` · Frost Shock `#9fdcff` · Earthbind `#e0a84a`
