# Verification — Corinda branding & shared config patch (2026-07-10)

Commit `05b28f8` ("Fix GGS branding leftovers, centralise term dates, correct labels")
was reviewed and functionally tested before landing on `main`.

## Review

- Diffed the incoming patch against the prior repository state file-by-file rather
  than trusting it as a raw diff (it was supplied as a full repo snapshot).
- Confirmed the shared `assets/site-config.js` term dates and games-hub URL match
  what every game previously hardcoded, so no game's schedule changed.
- Confirmed `archive/games/count-the-dots.html` is a byte-for-byte copy of the
  retired game before replacement.
- Verified new/changed word and category lists (Wordle, Connections) are internally
  consistent (e.g. added words exist in the matching length dictionary; Connections
  and Wheel of Fortune both cover all 40 weeks).
- Confirmed the `#wisdom` anchor ID collision fix in `character-strengths/index.html`
  removes a duplicate ID rather than introducing one.
- Confirmed the "N activities" labels on the strengths index now match the actual
  number of `<details>` activity entries per strength (previously mismatched).

## Testing

Served the repository locally and drove all 12 pages in `games/` with a headless
Chromium browser (Playwright):

- All 12 pages returned HTTP 200 with zero JavaScript errors.
- Console noise (missing `favicon.ico`, blocked Google Fonts) was confirmed
  unrelated to the patch and specific to the sandboxed test environment.
- Connections, Countdown, Crack the Code, Leaderboard, Wheel of Fortune, and
  Wordle all independently resolved the same current week from the shared
  `site-config.js`, confirming the centralized term-date config works across
  every game.
- Played a full round through Wordle (house/group select, guess, tile scoring),
  Connections (verified the patched "Parts of a school" category renders), and
  Wheel of Fortune (verified week label and puzzle text match for the resolved
  week) — all functioned correctly.
- Confirmed `games/count-the-dots.html` now serves the intended "retired" notice.

No functional regressions found.

---

# Verification — school server package (2026-07-24)

This package was checked after the final IIS/ASPX deployment patch, on the
`school-server` branch.

## Changes included

- Added `default.aspx` to redirect the site root to `public/index.aspx`.
- Added `web.config` to make `default.aspx` the default document and disable
  directory browsing.
- Changed the character strengths results links from the former GitHub Pages
  address to the local `index.aspx` page.
- Reworded the survey submission notice so the transmitted fields are explicit
  (full name, house, homegroup, top five strengths, top strength, VIA
  comparison response).
- Removed the public source-repository footer link from `public/index.aspx`.
- Removed Alphabucks' non-functional direct browser call to the Anthropic
  API. Alphabucks now uses local letter and duplicate checks only, with the
  teacher deciding whether an answer fits the category — matching every
  other game's validation approach.
- Rewrote `README.md` to describe the current `staff/`/`public/` structure
  and add school-server installation notes.

## Automated checks completed

- 23 ASPX pages detected, each with exactly one ASP.NET page directive.
- All internal links (games, character strengths, homegroup lessons) resolve
  correctly relative to the new `staff/`/`public/` structure.
- All inline JavaScript blocks passed `node --check` syntax validation.
- `web.config` parsed as valid XML with the expected default-document and
  directory-browsing settings.
- No remaining references to the old GitHub Pages site, the public GitHub
  source link, or the Anthropic API were found in deployable pages or scripts.
- The survey still contains and validates the full-name and homegroup
  fields and still maps them to the configured Microsoft Form.

## Installation smoke test required

Final confirmation must be performed on the school's actual IIS server, since
this package does not include or emulate the school's ASP.NET, Microsoft 365,
SharePoint, network-filtering or QLearn environment.

After installation, test:

1. The site root opens `public/index.aspx`.
2. A direct staff-page link opens correctly from QLearn.
3. A student survey submission prefills the correct school Microsoft Form
   fields, including full name and homegroup.
4. The character strengths result links stay on the school server.
5. The SharePoint leaderboard and other approved external services are
   reachable from a standard school device.
