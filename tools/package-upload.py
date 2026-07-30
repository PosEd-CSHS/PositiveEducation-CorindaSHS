#!/usr/bin/env python3
"""Assemble the zip that gets uploaded to the school website.

Contents:
    assets/   shared config and self-hosted fonts (open)
    public/   survey, directory and practice games (open)
    staff/    access-gated pages produced by tools/build-staff-gate.py

Deliberately excluded: default.aspx and web.config (unused under SharePoint),
repository documentation, and the tools/ directory.

Run tools/build-staff-gate.py first.
"""

import os, re, sys, zipfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
GATED = os.path.join(ROOT, 'dist', 'staff')
OUT = os.path.join(ROOT, 'dist', 'PosEd-sharepoint-upload.zip')

SOURCES = [('assets', os.path.join(ROOT, 'assets')),
           ('public', os.path.join(ROOT, 'public')),
           ('staff', GATED)]

assert os.path.isdir(GATED), 'run tools/build-staff-gate.py first'

files = []
for prefix, base in SOURCES:
    for dirpath, _, names in os.walk(base):
        for name in sorted(names):
            full = os.path.join(dirpath, name)
            arc = os.path.join(prefix, os.path.relpath(full, base)).replace(os.sep, '/')
            files.append((arc, full))
files.sort()

problems = []
for arc, full in files:
    if not arc.endswith('.aspx'):
        continue
    text = open(full, encoding='utf-8').read()
    # SharePoint document libraries refuse to render pages containing these.
    if '<%' in text:
        problems.append('%s: server-side code block' % arc)
    if arc.startswith('staff/'):
        if 'id="payload"' not in text:
            problems.append('%s: staff page is not gated' % arc)
    else:
        if 'id="payload"' in text:
            problems.append('%s: public page should not be gated' % arc)
assert not problems, 'refusing to package:\n  ' + '\n  '.join(problems)

with zipfile.ZipFile(OUT, 'w', zipfile.ZIP_DEFLATED) as z:
    for arc, full in files:
        z.write(full, arc)

gated = sum(1 for a, _ in files if a.startswith('staff/') and a.endswith('.aspx'))
openp = sum(1 for a, _ in files if a.startswith('public/') and a.endswith('.aspx'))
print('%s\n%d files, %.1f MB  (%d gated staff pages, %d open public pages)'
      % (OUT, len(files), os.path.getsize(OUT) / 1e6, gated, openp))
