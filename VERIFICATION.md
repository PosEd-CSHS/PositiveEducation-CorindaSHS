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

---

# Verification — staff access gate (2026-07-30)

The school's IT team confirmed they cannot set per-folder permissions on the
Corinda SHS website, and that rehosting the pages on a SharePoint subsite broke
CSS and scripting. The staff pages are therefore protected by encryption instead,
built by `tools/build-staff-gate.py` and packaged by `tools/package-upload.py`.

## How it works

- Each of the 16 staff pages is encrypted with AES-GCM under a key derived from a
  shared access key by PBKDF2-SHA256, 250,000 iterations. One salt per build, one
  random IV per page.
- The uploaded file contains only base64 ciphertext plus an unlock page. It is
  plain static HTML and client-side JavaScript — no server-side code, no
  configuration, nothing to change on the server.
- The QLearn links carry the access key in the URL fragment, so staff click
  through with nothing to type. Fragments are not sent to the server, so the key
  does not appear in server logs or referrer headers, and it is stripped from the
  address bar once the page unlocks.
- A successful key is cached in `sessionStorage` (not `localStorage`), so it is
  discarded when the browser closes rather than persisting on a shared classroom
  machine.

## Bug found and fixed during testing

`document.open()` is ignored while the HTML parser is still active. With a cached
key the decrypt completed fast enough for that to happen, so `document.write()`
injected the real page *into* the unlock page instead of replacing it, leaving
both documents merged in the DOM. The render now waits for `DOMContentLoaded`
before swapping the document in. Confirmed fixed on the same-tab navigation path
that originally exposed it.

## Automated checks completed

- 16 staff pages gated; 7 public pages confirmed **not** gated.
- Independent sweep of every gated file for 15 plaintext probes (answer banks,
  game markup, lesson content, external hosts, the new Term 4 panel): no leaks.
- Every payload confirmed to be pure base64; no `<% %>` blocks anywhere.

## Browser testing (Playwright/Chromium)

- QLearn link with the key unlocks the page; unlock page fully replaced; fragment
  stripped from the address bar.
- Relative dependencies survive the document swap — `../../assets/site-config.js`
  loads, the current week resolves from it, and the self-hosted Bebas Neue font
  loads from `../../assets/fonts/`. This was the main risk and it holds.
- Same-tab navigation to a second staff page with no key in the link unlocks from
  the session without re-prompting.
- Wrong key shows an error, and neither the answer bank nor the game markup is
  present anywhere in the DOM.
- No key: the fallback box unlocks the lessons page; all 20 lesson tabs render,
  the new Term 4 Weeks 9–10 panel displays, and the brain-breaks PDF is reachable.
- A full winning round of Wordle was played after unlocking, through to the
  result screen.
- Public pages open with no gate. No page errors or 404s on any page tested.

## Known limits

Anyone holding the access key can open the pages. There is no per-person access
or audit trail, and access cannot be revoked for one person without rotating the
key for everyone. The brain-breaks PDF is a separate file and is uploaded
unencrypted. Staff pages must therefore still not contain confidential student
information.
