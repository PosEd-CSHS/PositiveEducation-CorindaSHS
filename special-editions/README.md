# Special editions

One-off game editions for specific events or theme weeks — Book Week, and
whatever comes after it. These sit apart from the Home Group games in
`games/`: no weekly Home Group lock, no Microsoft Form submission, no
leaderboard tie-in. Anyone can open the page and play any number of times.
Because they're plain files on `main`, publishing one is just committing it —
GitHub Pages serves it immediately, with no SharePoint upload step.

## Where's Smoulder — Book Week (`smoulder-book-week.html`)

Same crowd-of-students engine as `games/smoulder.html`, with the game's own
existing single-themed-prop mechanism (previously used for one date-gated
weekly extra, e.g. the Book Week 📚 stack that still shows up in the regular
game in term 3 week 7) generalised into an `EVENT_EXTRAS` array that can hold
any number of extras, always on, not date-gated.

To make another event's edition:

1. Copy `smoulder-book-week.html` to a new file (e.g. `smoulder-harmony-day.html`).
2. Edit only the `EVENT_CONFIG` block near the top of the `<script>` — the
   `EVENT_NAME` and `EVENT_EXTRAS` array. Each entry is either:
   - `kind:'prop'` — a small canvas-drawn icon. Write a `drawX(x,y,s)`
     function next to the existing Book Week ones (`drawOpenBook`,
     `drawWizardHat`, `drawDragon`, `drawOwl`, `drawWand`) and point `draw` at
     it.
   - `kind:'image'` — a PNG/JPG instead of code. Set `src` to a same-origin
     image path or a `data:` URI; the generic `drawImageProp` function
     composites it, no new drawing code needed.
3. Use `tools/smoulder-character-calibrator.html` to tune each entry's
   `yOff`/`topRise`/`scale` against the actual crowd size range (26–80px)
   instead of guessing and reloading the real game repeatedly. It prints a
   config line ready to paste in.
4. Update the `<title>`, `<h1>`, intro paragraph and the extra `instr-card`
   in the instructions panel so the page describes its own event instead of
   Book Week.
5. Leave the permanent cast (chickens, alpacas, the six house mascots,
   Smoulder the Phoenix, Mr Bailey, farmer, scientist, drummer, soccer
   player, dancer) and everything below `EVENT_CONFIG` alone — that's the
   shared engine, not per-event content.

Deliberately removed from this template, unlike the regular Home Group
Smoulder: the once-per-week Home Group lock, the Microsoft Form score
submission, and the "see where your house is sitting" leaderboard link. A
special edition is for fun, played on demand — it doesn't feed the official
Home Group scoring data. If a future event genuinely needs scores collected,
that's a deliberate decision to wire back in, not a default.

## Shelf Search — Book Week (`bookshelf-book-week.html`)

A second, different template: a dense grid of lookalike items (here, book
spines on shelves) where most are filler and a handful are the real find —
clicking one shows an info panel instead of just a checkmark. This is the
right shape for "dozens of X, only a few of which matter": a wall of flags,
a paddock of farm animals, a rack of anything. It shares no code with the
Smoulder template — no crowd, no zoom-heavy human figures — because a tiled
grid of one repeated item is a genuinely simpler scene than a crowd, and
building it standalone keeps it that way rather than dragging in Smoulder's
unrelated complexity.

Everything from `// GRID ENGINE (generic)` down is the reusable part: slot
generation, the shelf/grid renderer, click hit-testing, the info modal, the
progress chips, win detection, zoom. To make another event's edition:

1. Copy `bookshelf-book-week.html` to a new file (e.g. `flags-pride-week.html`).
2. Edit `TARGET_DATA` — one entry per real find, each with a `color` and the
   text an info panel should show when it's clicked. The array length is the
   only thing that decides how many stars are hidden; nothing else needs to
   change to add or remove one.
3. Replace `drawSpine` (and the `FILLER_COLORS` palette) with whatever this
   event's tile actually looks like — a flag on a pole, an animal silhouette,
   whatever fits the theme. Keep drawing it as one function that takes
   `(x, w, baseline, h, color, starred)` so the grid engine doesn't change.
   The "how a real find gets marked" convention (small, low-contrast, near
   the base — not a giant beacon) is deliberate: see the note in `drawSpine`
   about sizing the star so it takes an actual look to spot. Don't make a
   future edition's tell bigger just because it's tempting to — a marker
   visible from across the whole grid turns "spot the difference" into
   "spot the obvious," which was a real problem in this file's first draft.
4. Adjust `SHELF_ROWS`/`SLOTS_PER_ROW` if the new grid needs a different
   shape, and update the header, instructions and the `<title>`.

**Content note:** the book facts here are safe, well-established trivia I
wrote myself. A Pride-flag edition's info panel would be showing real
community identity content (flag names, meanings) — that's worth having
whoever runs Pride Week at the school check for accuracy before it ships,
not something to publish from a general-knowledge first draft the way Book
Week's facts were.
