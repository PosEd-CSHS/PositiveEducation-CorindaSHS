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

---

# Verification — merged staff edits, 30-minute unlock window (2026-07-30)

A revised upload package was reviewed and merged. The 14 edited pages were
decrypted, adopted as the new `staff/` sources, and rebuilt.

## Edits reviewed and accepted

- Leaderboard: 11 hardcoded embed URLs replaced with `data-sheet` attributes and
  a single `WORKBOOK_EMBED_BASE` constant, so moving the workbook to a
  school-owned library becomes a one-line change. All 11 URLs were rebuilt the
  way the page's JavaScript does and compared against the originals — every one
  reproduces exactly, including `Where's Smoulder` and the lowercase sheet names.
  The `Overall totals` gridlines special-case is correct.
- Leaderboard: responsive grid with 960px and 640px breakpoints, `loading="lazy"`,
  iframe `title` attributes, and a note that the workbook may prompt for sign-in.
- Score submission: `✓ Submitted` / `disabled = true` became `↗ Reopen form` /
  `disabled = false`, so a blocked or closed Form popup no longer loses the score.
- The weekly-lock message now says "already played on this browser", which
  describes what the lock actually is.
- Accessibility: `aria-label`s on inputs and the six PERMAH sliders,
  `role="status" aria-live="polite"` on status regions, `title` on iframes, and
  `alt` on all 15 brain-break thumbnails. All 15 `alt` page numbers were checked
  against their PDF link targets and match.

## Unlock window changed

The revised package had removed the `sessionStorage` cache while keeping the
fragment stripping. Those two features depend on each other: with the key gone
from the address bar and nothing remembering it, a reload, a `?reset` link, or a
second staff page in the same tab all re-prompted for the key — awkward mid-lesson.

The cache is restored with a 30-minute idle timeout. Each staff page opened
renews the window, so it lapses 30 minutes after the last one, and
`sessionStorage` still discards it when the browser closes. This keeps reloads
working during a lesson without leaving the site unlocked all day on a shared
classroom machine.

## Second bug found and fixed

Because the fragment is stripped after unlocking, clicking the QLearn link for
the page you are already locked on changed only the fragment — which does not
reload the page, so the gate never saw the key and the link appeared to do
nothing. The gate now reloads on `hashchange` while it is showing, and removes
that handler before rendering the unlocked page.

## Checks completed

- All 16 pages decrypt; no plaintext leaks; no `<% %>` blocks; wrapper JavaScript
  passes `node --check`.
- Reload, `?reset` and second-page navigation all stay unlocked.
- An expired cache re-locks and the stale entry is cleared.
- A 28-minute-old key still unlocks, and opening a page renews the window.
- A fresh browser session does not inherit the unlock.
- A wrong key is refused with nothing leaked to the DOM.
- Clicking a same-page QLearn link from the gate unlocks correctly.
- All 11 leaderboard iframes receive a src.
- 20 lesson tabs, the Term 4 Weeks 9–10 panel and its thumbnail `alt` all render;
  a full winning round of Wordle plays through to the result screen and the
  Reopen-form button behaves.
- No page errors on any page tested.

---

# Verification — Crack the Code hints (2026-07-30)

Hints were reported as missing from Crack the Code. The repository's earliest
version of the file (commit `72a328d`, the initial upload) was checked and
contains no hint mechanic, so nothing had been removed here — any earlier
version predates the repository. Hints were added on request.

## Behaviour

- No hint before the first guess.
- After the first wrong guess: one blank per letter, grouped by word, plus a
  note giving the word count and the letters in each word.
- After the second wrong guess: the same pattern with each word's first letter
  filled in.
- Both derive from the answer string, so every week is covered without new
  puzzle data and no week can be left without a hint.

Scoring stays at 10 / 7 / 4. The scale already reduces the value of later
guesses, and scores have been recorded against it since the start of the year,
so changing it mid-year would make leaderboard totals inconsistent.

## Checks completed

- No hint shown before the first guess; reset hides it again.
- Hint 1 reveals no letters; its word count and per-word letter counts match
  the answer.
- Hint 2 reveals exactly the first letter of each word and nothing more; the
  full answer never appears in the hint.
- Solving on the third guess still scores 4.
- Each word renders as its own element, so word boundaries stay visible. The
  longest phrase in the bank (seven words) renders correctly and causes no
  horizontal overflow.
- Inline JavaScript passes `node --check`; no page errors.

## Noted, not changed

`WEEK_PLAN` in Crack the Code has 38 of 40 entries — Term 4 Weeks 9 and 10 are
absent, so those weeks fall back to the default puzzle rather than a themed one.
Wordle, Connections and Wheel of Fortune all cover 40 weeks, and the lesson file
now does too.

---

# Verification — score form fallback when the browser blocks the tab (2026-07-30)

A teacher reported that the score form link was not working. Investigation
found the link itself was correct in every game; the failure was that the
games did not notice when the browser refused to open it.

## What was wrong

Every game called `window.open(...)` and assumed success. A blocked tab makes
that call return null, so the form never opened — yet the game displayed
"Form opened in a new tab", then relabelled the button "Reopen form", which
repeated the same blocked call. The teacher was told the score had been
submitted when it had not.

## What was verified as correct

Each game was driven in a browser and the URL it actually generates was
captured and parsed. All ten produce a valid link: host `forms.cloud.microsoft`,
the correct form id, and all five pre-fill fields present. No `forms.office.com`
remains anywhere. The archived `staff/archive/games/count-the-dots.aspx` still
carries the same form id; it is retired and unlinked, so it was left alone.

## The change

Each game now calls `cshsOpenForm()`. If the tab opens, behaviour is unchanged.
If it is blocked, the helper hides the false confirmation and shows a link
beside the submit button, pre-filled with the same values. A link click is never
blocked, so this works under any browser policy. The link is hidden again if a
later attempt succeeds. Wheel of Fortune's lower-case form path was also
normalised to match the other nine.

## Checks completed

- All ten games pass `node --check`.
- With the tab blocked, every game creates the fallback and places it directly
  beside its submit button.
- Full playthroughs of Wordle, Crack the Code and Stop the Clock with the tab
  blocked: the fallback is visible and clickable, and its link carries the real
  house, group and score. Guess the Strength was verified with a completed
  result object.
- No element claiming the form opened remains visible once a block is detected.
- When the tab opens successfully the fallback is hidden again.
- No page errors in any game.

Two games needed their real flow to test at all: Guess the Strength returns
early without a completed result, and Stop the Clock requires three player
turns before its submit form appears. Both behave correctly once played.

---

# Diagnosis — score form returning HTTP 500 (2026-08-05)

A screen recording of the reported failure identified the cause, which was not
the one suspected earlier.

## What the recording shows

The teacher opened Guess the Strength from QLearn at
`https://posed-cshs.github.io/PositiveEducation-CorindaSHS/games/guess-the-strength.html`
— the GitHub Pages site, which serves the `main` branch, not the school server.

The game played through correctly and the score form tab did open. The form
itself failed: "This page isn't working at the moment — forms.office.com can't
currently handle this request. HTTP ERROR 500". The address bar confirms the
host as `forms.office.com`, with the form id and pre-filled week visible.

## Cause

The move from `forms.office.com` to `forms.cloud.microsoft` was applied to this
`school-server` branch only. Every game published on GitHub Pages still pointed
at the old host, where Microsoft now returns a 500 for these pre-filled links.
All 17 references on `main` have been migrated. The form id and the five
pre-fill field ids are unchanged, so recorded responses and the leaderboard are
unaffected.

## Correction to the earlier diagnosis

The blocked-pop-up fallback added earlier did not cause and does not fix this.
The tab opened; the form behind it errored. That fallback remains worth having,
but it was not this failure.

## Not verifiable from here

This environment's network policy blocks Microsoft hosts, so neither domain
could be requested to confirm the fix end to end. The recording is direct
evidence that `forms.office.com` fails for this form; that
`forms.cloud.microsoft` succeeds must be confirmed on a school device.

## Still outstanding

Teachers are reaching the games through GitHub Pages, so `main` — not the
school-server package — is what they actually use. The two branches have
diverged, and QLearn links should be pointed at whichever is intended to be
live.
