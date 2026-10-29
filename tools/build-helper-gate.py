#!/usr/bin/env python3
"""Build the password-gated HELPER copy of the Home Group games.

Selected students help their teacher run Home Group activities. They get the
games and nothing else, behind a separate password, so the staff access key
(which opens every page in staff/, including lessons) never goes near them.

The pages are not copied into the repository a second time. This script reads
the staff game pages in staff/games/, switches off the teacher shortcuts that
would let a helper replay a game or preview another week, encrypts the result
with the helper password, and writes dist/helpers/games/. Scores still go to
the same Microsoft Form and the same leaderboard workbook, because the pages
are otherwise identical.

Usage:
    python3 tools/build-helper-gate.py                    # new random password
    python3 tools/build-helper-gate.py --key "a-b-c-d"    # reuse a password

Then run tools/package-upload.py, which adds dist/helpers/ to the upload zip.
"""

import argparse, importlib.util, os, re, secrets, shutil, sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC_DIR = os.path.join(ROOT, 'staff')
OUT_DIR = os.path.join(ROOT, 'dist', 'helpers')

_spec = importlib.util.spec_from_file_location(
    'staff_gate', os.path.join(ROOT, 'tools', 'build-staff-gate.py'))
gate = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(gate)

# Helpers get the games and the Home Group activity cards, and nothing else: no
# leaderboard and no brain breaks. The hub is rebuilt below to match.
PAGES = ['homegroup-lessons/homegroup-lessons.aspx',
         'games/index.aspx', 'games/wordle.aspx', 'games/connections.aspx',
         'games/wheel-of-fortune.aspx', 'games/alphabucks.aspx',
         'games/smoulder.aspx', 'games/stop-the-clock.aspx',
         'games/weekly-trivia.aspx', 'games/geoguessr.aspx']

# Teacher shortcuts that a helper must not have: ?reset clears the one-play-a-week
# lock on a device, ?test skips it, ?week previews another week's puzzle, and
# ?builder opens the GeoGuessr round editor. Each is switched off by replacing
# the condition, and the build fails if the text it expects has moved, so a
# shortcut can never quietly survive a refactor.
RESET = ("location.search.includes('reset')", 'false', 1)
HARDEN = {
    'games/wordle.aspx': [RESET],
    'games/connections.aspx': [RESET],
    'games/wheel-of-fortune.aspx': [RESET],
    'games/alphabucks.aspx': [RESET],
    'games/smoulder.aspx': [RESET],
    'games/geoguessr.aspx': [('params.has("test")', 'false', 1),
                             ('params.get("week")', 'null', 2),
                             ('new URLSearchParams(location.search).has("builder")', 'false', 1)],
    # The brain break PDF is a plain file, so it stays in staff/ and is linked from there.
    'homegroup-lessons/homegroup-lessons.aspx': [
        ('href="Brain_breaks_ordered.pdf#page=',
         'href="../../staff/homegroup-lessons/Brain_breaks_ordered.pdf#page=', 3)],
}

# The helper hub swaps its Leaderboards section for the Home Group activity cards.
HUB_SECTION = re.compile(r'  <section>\n    <div class="section-head"><h2>Leaderboards</h2>.*?</section>\n\n', re.S)
HUB_ACTIVITIES = """  <section>
    <div class="section-head"><h2>Activities</h2><span>ready-to-run cards for Home Group</span></div>
    <div class="grid">
      <a class="card" href="../homegroup-lessons/homegroup-lessons.aspx">
        <span class="card-emoji">\U0001F4D8</span>
        <div class="card-title">Home Group Lessons</div>
        <div class="card-desc">Fortnightly activity cards. Open the one marked THIS WEEK and follow the numbered steps.</div>
      </a>
    </div>
  </section>

"""

# Wording for the helper gate. Every replaced string must occur exactly once.
WORDING = [
    ('<title>Staff Resources — Corinda SHS Positive Education</title>',
     '<title>Home Group Helpers — Corinda SHS</title>'),
    ('<h1>Staff Resources</h1>', '<h1>Home Group Helpers</h1>'),
    ('<label for="pw">Access key</label>', '<label for="pw">Helper password</label>'),
    ('posed.staff.key', 'posed.helper.key'),
    ('Enter the staff access key to open this page.',
     'Enter the helper password to open this page.'),
    ('That key is not correct. Check the Positive Education page in QLearn.',
     'That password is not correct. Ask your teacher for the helper password.'),
    ('The key in this link is not valid. Open the page again from QLearn, "+\n'
     '           "or type the current access key below.',
     'The password in this link is not valid. Ask your teacher for the "+\n'
     '           "current link, or type the helper password below.'),
    ('This browser is too old to open the staff pages. ',
     'This browser is too old to open the helper pages. '),
]


def helper_wrapper():
    w = gate.WRAPPER
    hint_start = w.index('<p class="hint">')
    hint_end = w.index('</p>', hint_start) + len('</p>')
    w = (w[:hint_start] +
         '<p class="hint">Your teacher gives you the helper password. These pages are only '
         'for students helping to run Home Group games.</p>' + w[hint_end:])
    for old, new in WORDING:
        assert w.count(old) == 1, 'gate wording moved: %r' % old[:50]
        w = w.replace(old, new)
    return w


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--key', help='reuse an existing helper password')
    ap.add_argument('--base-url', default='https://corindashs.eq.edu.au/Documents/PosEd')
    args = ap.parse_args()

    key = args.key or gate.make_key()
    salt = secrets.token_bytes(16)
    raw_key = gate.derive(key, salt)
    wrapper = helper_wrapper()

    if os.path.isdir(OUT_DIR):
        shutil.rmtree(OUT_DIR)

    for rel in PAGES:
        text = open(os.path.join(SRC_DIR, rel), encoding='utf-8').read()
        for old, new, want in HARDEN.get(rel, []):
            assert text.count(old) == want, \
                '%s: expected %d of %r, found %d' % (rel, want, old, text.count(old))
            text = text.replace(old, new)
        if rel == 'games/index.aspx':
            assert len(HUB_SECTION.findall(text)) == 1, 'hub layout moved: cannot swap in the Activities section'
            text = HUB_SECTION.sub(lambda m: HUB_ACTIVITIES, text)
            assert 'leaderboard' not in text.lower(), 'hub still mentions the leaderboard'
        iv, ct = gate.encrypt(text.encode('utf-8'), raw_key)
        page = (wrapper.replace('__PAYLOAD__', gate.b64(ct)).replace('__SALT__', gate.b64(salt))
                .replace('__IV__', gate.b64(iv)).replace('__ITER__', str(gate.ITERATIONS)))
        assert '<%' not in page, '%s: server-side code block in wrapper' % rel
        for probe in ('WEEKLY_WORDS', 'PUZZLES', 'Home Group Leaderboard', 'const ROUNDS'):
            assert probe not in page, '%s: plaintext %r leaked into the gated page' % (rel, probe)
        dst = os.path.join(OUT_DIR, rel)
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        open(dst, 'w', encoding='utf-8').write(page)

    lines = ['# Helper links', '', 'Helper password: `%s`' % key, '',
             'Give helpers one of these links. Each already carries the password.', '']
    for rel in PAGES:
        lines.append('- %s/helpers/%s#k=%s' % (args.base_url, rel, key))
    open(os.path.join(ROOT, 'dist', 'helper-links.md'), 'w', encoding='utf-8').write('\n'.join(lines) + '\n')
    print('helper password: %s' % key)
    print('%d helper pages written to %s' % (len(PAGES), OUT_DIR))


if __name__ == '__main__':
    main()
