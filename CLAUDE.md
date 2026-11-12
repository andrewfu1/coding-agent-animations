# Coding Agent Animations: instructions for coding agents

three.js animations built by AI coding agents. Each **collection** is a folder; each animation is one self-contained HTML file.

## Before you build anything

1. Find the collection's style in its `README.md` (`Style: voxel`, ...), then **read `styles/<style>.md` in full**. It defines the quality bar, the tech setup, the known pitfalls, and how to verify.
2. Open the reference scene the style guide names and match its level of detail. New work should look like it belongs next to it.
3. For a new collection with a new look, write `styles/<new-style>.md` first (same sections as `styles/voxel.md`) and agree on it with the user before building.

## Hard rules

- **No AI slop.** Don't add text or UI nobody asked for: no titles, subtitles, taglines, zone/scenario labels, captions, step lists, legends, descriptions, "coming soon" placeholders or explanatory blurbs, in the scene or on picker pages. The animation is the content. The only text is what the subject itself would show (for a game: ability names, cast bar, nameplates, numbers, a small unit frame).
- **Self-contained HTML.** No build step. Libraries come from a CDN with pinned versions (three.js `0.160.0`). It must work by double-clicking the file; never require a local server.
- **Never stand still.** Simulated characters loop forever, and every resource or cooldown dead end has a fallback.
- **Verify like a skeptic** (see the style guide): run `tools/sim.sh`, force the edge cases, take a close-up with `tools/shot.sh`, and actually look at it. "It looked like a flash" is not a diagnosis.

## Layout

```
index.html           home page: one card per collection (cover image + title + style tag)
CLAUDE.md            this file
styles/<style>.md    one guide per art style (voxel, tiltshift, ...)
tools/               sim.sh (headless run + state log), shot.sh (headless screenshot)
<collection>/        index.html (picker), README.md (subject + "Style:" line), cover.jpg, one .html per animation
```

To add a collection: make the folder, render a `cover.jpg` (about 960px wide, no HUD), and add an entry to `COLLECTIONS` in the root `index.html`.
