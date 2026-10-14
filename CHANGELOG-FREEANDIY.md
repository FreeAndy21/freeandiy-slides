<!-- Modified-by: FreeANDIY (Free Andy Agency), 2026. New file, not part of upstream DeckCraft. -->
# FreeANDIY Slides: changes from upstream DeckCraft

This file lists what the FreeANDIY fork changes in DeckCraft (Apache-2.0 section 4(b)). The
exact changes are generated from `freeandiy/` (see `NOTICE`); `git diff upstream-main main`
shows every changed file.

## Unreleased

### Branding
- Product name **FreeANDIY Slides** everywhere users see it: window title, ribbon, Backstage,
  About, messages, installers, desktop entries, the web page, the CLI and the MCP server.
- Application id `agency.freeandy.slides` (was `ai.storyteller.deckcraft`), so FreeANDIY builds
  install next to DeckCraft. The `.deckcraft` document format and its MIME type stay, so files
  open in both apps.
- Executables `freeandiy-slides` and `freeandiy-slides-cli`; the cargo packages keep their names.
- New app icon set and in-app mark (the angel Andy, Free Andy Agency) and DMG background.
- Light and dark themes in FreeANDIY's paper-and-ink print look (no soft shadows, the stamp-rose
  accent); the canvas around the slide stays neutral grey.
- UI font IBM Plex Sans (OFL 1.1) on the desktop.

### Removed
- The ArtCraft name, wordmark and logos (`docs/brand/`), as their terms require of forks.
- The ArtCraft Discord links (Backstage, About, CLI, MCP server, `app.links`).
- Upstream's release and platform workflows (upstream's CI still runs `cargo xtask ci`).

### Added
- About: attribution to upstream DeckCraft and the Free Andy Agency seal.
- `NOTICE` section and `ATTRIBUTION.md` rows for FreeANDIY's assets and fonts; packages, the
  Windows portable ZIP included, now ship `NOTICE`, `ATTRIBUTION.md`, the font licences and the
  brand terms.
