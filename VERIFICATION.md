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
