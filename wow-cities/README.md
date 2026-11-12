# WoW Forever Cities

Tilt-shift voxel dioramas of the six classic racial capitals as they appear in **WoW Forever**. Each city is a living miniature that loops forever: citizens walk the streets and stop at shops and doors, guards patrol and stand at the gates, riders trot by, and flying mounts circle and land at the flight master. Every city also runs its own machine on a cycle. Everything is coded by agents: one self-contained HTML file per city, with no build step and no image assets.

**Style: tiltshift.** See `../styles/tiltshift.md` for the quality bar, tech, pitfalls and how to verify; `../CLAUDE.md` for repo rules.

## Files

| File | City | Landmarks | Always moving |
|---|---|---|---|
| `stormwind.html` | Stormwind (human) | canals split the city into districts: the Valley of Heroes (giant hero statues, braziers) from the gate to the Trade District island (bank colonnade, the Gilded Rose, market stalls), the violet-roofed Mage Quarter round the Wizard's Sanctum (W), Old Town (E), Cathedral Square with the Cathedral of Light and fountain, the Park and its pond (NW), Stormwind Keep on its terrace, the Dwarven District forge and Deeprun Tram gate (NE) | day/night, a ship sailing around the island, the fountain, arcane orbs, the tram cog turning, forge smoke, gryphons |
| `ironforge.html` | Ironforge (dwarf, gnome) | districts carved as open chambers into a snow-capped mountain and joined by arched tunnels: the great gate with two dwarf statues (S), the Commons round the Vault of Ironforge, the Great Forge in the middle (four pillars, lava ring, lavafalls), the Military Ward (E), the Mystic Ward (W), Tinker Town and the Deeprun Tram tunnel (NE), the Hall of Explorers with its fossil skeleton (N), the Forlorn Cavern (NW) | the cauldron tips and pours every 22s, two lavafalls, smiths hammering at anvils, a tram cart shuttling into its tunnel, the Tinker Town cog, arcane orbs, snow, gryphons |
| `darnassus.html` | Darnassus (night elf) | high in the canopy of Teldrassil, with boughs, the trunk and clouds falling away below: the central lake with the Temple Gardens island (the Bough of the Eternals) and three arched causeways, the Temple of the Moon with its moonwell and statue (S), Warrior's Terrace and the living-wood gate (E), Craftsmen's (NE) and Tradesmen's (SE) Terraces, the Cenarion Enclave's druid trees (NW), the moon-gate portal to Rut'theran (W) | the moonbeam, wisps, fireflies, falling violet leaves, the portal swirl, drifting clouds, sentinels on nightsabers, deer, hippogryphs |
| `orgrimmar.html` | Orgrimmar (orc, troll) | valleys carved into a red-rock mesa in Durotar: the spiked main gate in the canyon mouth, the Valley of Strength (fire totem, huts, the wind rider tower), the Drag winding NE with shops dug into its walls and a plank skyway overhead, the Valley of Honor (Hall of the Brave, training dummies), the Valley of Wisdom with Grommash Hold, the troll Valley of Spirits round its pond, the sunken Cleft of Shadow, the zeppelin tower out on the plain | day/night, the zeppelin flies a loop and docks, the wind rider lift, braziers and voodoo fires, blowing dust, wyverns, wolf, raptor and kodo riders |
| `thunderbluff.html` | Thunder Bluff (tauren) | the central bluff with the Wind Rider Roost atop its great totem pole and the chieftain's longhouse; rope bridges to Elder Rise (NE), Spirit Rise (W: the Pools of Vision cave, spirit stones, the zeppelin tower) and Hunter Rise (S); lifts SW and NE; a waterfall into the lake | day/night, the zeppelin flies in, moors and leaves, two lifts going up and down, a kodo caravan on the plains, wind riders |
| `undercity.html` | Undercity (forsaken) | the ruins of Lordaeron above (the throne room with the lifts at its back, broken walls, graves); below, the round Trade Quarter (bank pillar, sludge canal, bridges) with passages to the Magic (NE), War (NW), Rogues' (SE) Quarters and the Apothecarium (SW), and on to Sylvanas's Royal Quarter (S) | the sludge bubbles, Apothecarium cauldrons, arcane orbs, a hovering banshee, lifts between the ruins and the city, abominations on patrol, bats |

Open `index.html` directly in a browser. No server needed. Deep-link with `#stormwind`, `#orgrimmar`, etc. Drag to orbit and scroll to zoom.

## How each city is built

- **Island:** one InstancedMesh of 1×1 columns from `terrain((x,z,r)=>[height,color])`. Static props go into a second InstancedMesh, and lit windows and lamps into a third that glows at night.
- **People:** a node graph (`node`, `link`, `loop`). Citizens random-walk it and stop at `stop` nodes. Guards follow fixed routes or stand still, riders use `mounted(quad(...), humanoid(...))`. Groups that must stay apart (mesa tops and the plains, the Undercity floor and the ruins) are kept that way with node flags and `avoid`.
- **Races** come from one `humanoid({race})` builder: human, dwarf, gnome, nelf, orc, troll, tauren, undead.
- **Flyers:** `flight(model, loopPoints, {roost})` loops, lands, rests and takes off again.

## Palettes

| City | Palette |
|---|---|
| Stormwind | sky `#a9d4f0`, white stone `#e6e2d6`, slate-blue roofs `#3e5c9c`, cream plaster + dark timber, grass HSL(.27,.5,.4) |
| Ironforge | sky `#c8dcec`, snow HSL(.58,.25,.92), hall stone `#6e6862`, lava `#ff6a1a`, gold trim `#d9a93a` |
| Darnassus | twilight `#2a3266`, teal grass HSL(.42,.42,.33), lavender stone `#dcd4ec`, purple roofs `#6a4aa0`, moonlight `#9ad8ff` |
| Orgrimmar | dusty sky `#e9c9a2`, red rock HSL(.05,.48,.49), logs `#6b4428`, hides `#b8874a`, bone `#ece4d0`, banners `#a32a1f` |
| Thunder Bluff | sky `#bfe0f4`, plains HSL(.2,.5,.47), striped mesa rock, hide `#e8d8b0`, painted reds/blues/golds |
| Undercity | night `#1d1a2c`, ruin stone `#8a8a88`, floor stone HSL(.65,.06,.45), sludge `#58c83a`, Forsaken purple `#5a2a7a` |
