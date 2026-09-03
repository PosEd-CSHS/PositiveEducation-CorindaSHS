# Working in this repository

Home Group resources for Corinda State High School's Positive Education program —
games, character-strengths tools, fortnightly lesson guidance, and a staff PERMAH
course. Deployed two different ways from two different branches. This file
records the things that aren't obvious from the code, mostly learned by getting
them wrong once.

## Two branches, two deployments, neither one obvious

- **`main`** deploys automatically to GitHub Pages on every push, via the
  repo's own `pages-build-deployment` GitHub Actions workflow (Jekyll-built).
  No CI to babysit, no build step to run — a push to `main` is live within
  about a minute.
- **`school-server`** deploys to a SharePoint document library, and pushing to
  it **does nothing by itself**. Publishing is a manual step someone runs from
  a checkout: `tools/build-staff-gate.py` + `tools/package-upload.py`, then a
  hand upload. Those two scripts (plus `tools/verify-staff-gate.py`) live only
  on this branch — `main` has no `tools/build-staff-gate.py`, don't go looking
  for it there.

Because of that gap, `school-server`'s README carries a **deployment status**
note naming the last commit actually uploaded and roughly when. Update it
(hash + date) every time a real upload happens — otherwise there's no way to
tell how stale the live SharePoint copy is relative to the branch.

The two branches also have different file layouts, not just different
extensions: `main` is flat (`homegroup-lessons/homegroup-lessons.html`),
`school-server` splits by audience (`staff/homegroup-lessons/homegroup-lessons.aspx`,
`public/…` for the sign-in-free pages). Any content change has to be ported to
both, at both paths — diff the two versions before pushing to confirm they
actually match once the change lands, the same way you'd confirm any patch
applied cleanly. A `git worktree add` of `school-server` alongside the `main`
checkout is the easiest way to do this without losing track of which tree
you're editing.

**GitHub Pages URL casing is not what you'd guess.** The org name lowercases
(`posed-cshs`) but the repo name keeps its exact case
(`PositiveEducation-CorindaSHS`) — the real URL is
`https://posed-cshs.github.io/PositiveEducation-CorindaSHS/…`, not the
all-lowercase form you'd construct by convention. Confirmed by reading the
`pages-build-deployment` workflow's own run logs (`Evaluated environment
url:`), not by guessing — guessing this one produced a real, working-looking
URL that actually 404'd.

## The VIA character strengths list is canonical in exactly one place

`assets/site-config.js`'s `strengths` array assigns one strength (or theme, for
orientation/review weeks) to each of the 40 teaching weeks, in order. Every
week-scoped mention of a strength anywhere else in the repo should trace back
to this array — it's the same "one implementation per rule" logic as the
sibling `science` repo, applied to strength-week assignment instead of
curriculum data.

Two bug shapes have shown up more than once from content drifting away from
that array:

- **Borrowing a neighbouring week's strength.** A "Courage & Zest" fortnight's
  activity described itself as being about "Bravery" — a real VIA strength,
  just the *next* fortnight's, not this one's. The tell was subtle because
  Bravery and Courage are closely related (Bravery is one of the four
  strengths under the Courage virtue), so it reads as plausible right up until
  you check the actual per-week assignment.
- **Retired or inconsistent naming.** Content used "Citizenship" where the
  rest of the site — including that strength's own dedicated week — calls it
  "Teamwork." Same VIA strength, two names never reconciled.

To audit for either: compute each week's canonical strength as
`strengths[(term-1)*10 + (week-1)]` (terms and per-term weeks are both
1-indexed in the page headers, 0-indexed in the array), then check every "the
X strength" mention in that week's content against it — and against its
*paired* week where a virtue name doubles as one week's placeholder (e.g. a
"Courage & Zest" fortnight: week 1 of the pair is literally labelled with the
virtue name "Courage," week 2 gets the real specific strength "Zest"). A
mention that isn't the week's own strength, its pair's, or the parent virtue
name itself is worth a second look before assuming it's deliberate contrast
rather than drift.

## Editing homegroup-lessons.html without corrupting it

It's one very long, largely hand-formatted HTML file with no build step, so
edits are string surgery, not a template render. Two things about that shape
have bitten before:

- **Don't relocate a sibling block by searching for its content** right after
  splicing in new content nearby — if the new text happens to share a phrase
  with the sibling (a straight vs. curly apostrophe was enough), the search
  finds the wrong block and swaps two sections silently. Locate the very next
  sibling **by position** (the offset right after the block you just spliced
  in ends) instead, and take whatever div starts there — it can't be fooled by
  wording.
- **Not every activity block carries the same class.** Most use
  `class="lesson-card"`, but at least one otherwise-identical block (same
  `style="background:#e8f5e9…"` shape, no `class` attribute) doesn't — a
  `class="lesson-card"` search alone silently skipped it, once. Match on the
  `background:#e8f5e9` / `background:#fffbee` style signature shared by every
  activity block, not the class attribute, when the goal is to find all of
  them.

After any edit: serve the file locally (`python3 -m http.server`) and drive it
with Playwright — call `show(N)` for a handful of panel indices, check
`#panel-N` is visible and the console is clean. There's no test suite here to
run instead. `.aspx` files need a small custom `http.server` subclass that
maps the extension to `text/html`, or the browser tries to download the file
instead of rendering it — stock `SimpleHTTPRequestHandler` doesn't know that
extension.

## Generated Word documents

When a request needs the site's content as a `.docx` (a review table, a full
lesson dump for markup and re-upload), build it with the `docx` npm package
rather than hand-writing anything — and validate the result against the OOXML
schema before sending it (the `docx` skill's `validate.py`). A JS array
returned from a helper function and spliced into a `children: [...]` list
*without* spreading it (`...bullets([...])`, not `bullets([...])`) produces a
docx that LibreOffice and the schema validator both reject outright — caught
once, worth remembering the spread every time.
