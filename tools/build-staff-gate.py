#!/usr/bin/env python3
"""Build access-gated copies of the staff pages for the school website.

The pages in staff/ stay readable and editable in this repository. This script
encrypts each one and writes a self-contained wrapper page to dist/staff/, so
the file uploaded to the school website contains no readable page content.

A wrapper unlocks when it is opened with the access key in the link fragment
(the QLearn links carry it), or when the key is typed into the fallback box.
The unlocked key is remembered for the browser session, so moving between
staff pages does not re-prompt.

Usage:
    python3 tools/build-staff-gate.py                 # new random key
    python3 tools/build-staff-gate.py --key "a-b-c-d"  # reuse a key

Everything is plain static HTML and client-side JavaScript. No server-side
code, no configuration, nothing for IT to change.
"""

import argparse, base64, hashlib, json, os, re, secrets, shutil, sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC_DIR = os.path.join(ROOT, 'staff')
OUT_DIR = os.path.join(ROOT, 'dist', 'staff')
ITERATIONS = 250_000

WORDS = """amber anchor apricot basalt beacon bramble bronze cedar cinder clover
compass copper cricket crimson dapple dovetail ember fathom ferry flint forge
garnet granite harbour hazel heron ivory jasper kestlin lantern linden lupin
marble marlin meadow mistral nectar nimbus oaken onyx osprey paddock pelican
pewter pigeon plover quarry quiet rafter ripple rosella saffron sandpiper
sequoia shale slate sorrel spinnaker sterling sumac tamarind teal thistle
timber topaz trellis tundra verbena vesper walnut warbler willow yarrow""".split()


def make_key():
    return '-'.join(secrets.choice(WORDS) for _ in range(4))


def derive(passphrase, salt):
    return hashlib.pbkdf2_hmac('sha256', passphrase.encode('utf-8'), salt,
                               ITERATIONS, dklen=32)


def encrypt(plaintext_bytes, raw_key):
    from cryptography.hazmat.primitives.ciphers.aead import AESGCM
    iv = secrets.token_bytes(12)
    ct = AESGCM(raw_key).encrypt(iv, plaintext_bytes, None)
    return iv, ct


def b64(b):
    return base64.b64encode(b).decode('ascii')


WRAPPER = """<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="robots" content="noindex,nofollow">
<title>Staff Resources — Corinda SHS Positive Education</title>
<style>
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:'Segoe UI',Tahoma,sans-serif;background:#00180f;color:#fdfdfd;
min-height:100vh;display:flex;align-items:center;justify-content:center;padding:24px}
.card{max-width:420px;width:100%;background:rgba(255,255,255,.05);
border:1px solid rgba(242,180,0,.3);border-radius:12px;padding:28px}
.eyebrow{font-size:11px;letter-spacing:.12em;text-transform:uppercase;color:#f2b400;margin-bottom:8px}
h1{font-size:24px;font-weight:700;margin-bottom:12px}
p{font-size:14px;line-height:1.55;color:rgba(255,255,255,.72);margin-bottom:14px}
label{display:block;font-size:12px;text-transform:uppercase;letter-spacing:.08em;
color:#f2b400;margin-bottom:6px}
input{width:100%;padding:10px 12px;font-size:15px;border-radius:8px;
border:1px solid rgba(255,255,255,.25);background:rgba(0,0,0,.25);color:#fdfdfd}
input:focus{outline:2px solid #f2b400;outline-offset:1px}
button{margin-top:12px;width:100%;padding:10px;font-size:15px;font-weight:700;
border:0;border-radius:8px;background:#f2b400;color:#00180f;cursor:pointer}
button:disabled{opacity:.6;cursor:default}
.err{color:#ffb4a2;font-size:13px;margin-top:10px}
.hint{font-size:12px;color:rgba(255,255,255,.5);margin:14px 0 0}
#form{display:none}
</style>
</head>
<body>
<div class="card">
  <div class="eyebrow">Corinda State High School</div>
  <h1>Staff Resources</h1>
  <p id="msg">Unlocking…</p>
  <form id="form">
    <label for="pw">Access key</label>
    <input id="pw" type="password" autocomplete="current-password" autocapitalize="off" spellcheck="false">
    <button type="submit" id="go">Unlock</button>
    <p class="err" id="err" hidden></p>
  </form>
  <p class="hint">Staff resources are usually opened from the Positive Education
  page in QLearn, which unlocks them automatically. The access key is listed there.</p>
</div>
<script type="text/plain" id="payload">__PAYLOAD__</script>
<script>
(function(){
"use strict";
var SALT="__SALT__", IV="__IV__", ITER=__ITER__, SK="posed.staff.key";
var msg=document.getElementById("msg"), form=document.getElementById("form");
var err=document.getElementById("err"), pw=document.getElementById("pw");
var go=document.getElementById("go");

function bytes(s){
  var bin=atob(s.replace(/\\s+/g,"")), n=bin.length, out=new Uint8Array(n);
  for(var i=0;i<n;i++){out[i]=bin.charCodeAt(i);}
  return out;
}
function tob64(u8){
  var s="",C=0x8000;
  for(var i=0;i<u8.length;i+=C){s+=String.fromCharCode.apply(null,u8.subarray(i,i+C));}
  return btoa(s);
}
function showForm(text){
  msg.textContent=text;
  form.style.display="block";
  pw.focus();
}
function fail(text){
  err.hidden=false; err.textContent=text;
  go.disabled=false; go.textContent="Unlock";
}
// document.open() is ignored while the parser is still active, which would make
// document.write() inject into this page instead of replacing it. With a cached
// key the decrypt finishes fast enough for that to happen, so wait for parsing
// to finish before swapping the document in.
function parsed(){
  return new Promise(function(res){
    if(document.readyState!=="loading"){res();return;}
    document.addEventListener("DOMContentLoaded",function(){res();},{once:true});
  });
}
function render(html){
  return parsed().then(function(){
    try{history.replaceState(null,"",location.pathname+location.search);}catch(e){}
    document.open();
    document.write(html);
    document.close();
  });
}
function derive(pass){
  var enc=new TextEncoder();
  return crypto.subtle.importKey("raw",enc.encode(pass),"PBKDF2",false,["deriveBits"])
    .then(function(base){
      return crypto.subtle.deriveBits(
        {name:"PBKDF2",salt:bytes(SALT),iterations:ITER,hash:"SHA-256"},base,256);
    }).then(function(bits){return new Uint8Array(bits);});
}
function attempt(raw){
  return crypto.subtle.importKey("raw",raw,"AES-GCM",false,["decrypt"])
    .then(function(k){
      return crypto.subtle.decrypt({name:"AES-GCM",iv:bytes(IV)},k,
        bytes(document.getElementById("payload").textContent));
    })
    .then(function(buf){
      var html=new TextDecoder().decode(buf);
      try{sessionStorage.setItem(SK,tob64(raw));}catch(e){}
      return render(html).then(function(){return true;});
    })
    .catch(function(){return false;});
}

if(!window.crypto||!crypto.subtle||!window.TextDecoder){
  msg.textContent="This browser is too old to open the staff pages. "+
    "Please use a current version of Edge, Chrome, Firefox or Safari.";
  return;
}

var cached=null;
try{cached=sessionStorage.getItem(SK);}catch(e){}
var hash=/[#&]k=([^&]+)/.exec(location.hash||"");

(function start(){
  if(cached){
    attempt(bytes(cached)).then(function(ok){
      if(ok){return;}
      try{sessionStorage.removeItem(SK);}catch(e){}
      cached=null; start();
    });
    return;
  }
  if(hash){
    derive(decodeURIComponent(hash[1])).then(attempt).then(function(ok){
      if(ok){return;}
      showForm("That link is out of date.");
      fail("The key in this link is not valid. Open the page again from QLearn, "+
           "or type the current access key below.");
    });
    return;
  }
  showForm("Enter the staff access key to open this page.");
})();

form.addEventListener("submit",function(e){
  e.preventDefault();
  var v=pw.value.trim();
  if(!v){return;}
  err.hidden=true; go.disabled=true; go.textContent="Unlocking\\u2026";
  derive(v).then(attempt).then(function(ok){
    if(!ok){fail("That key is not correct. Check the Positive Education page in QLearn.");}
  });
});
})();
</script>
</body>
</html>
"""


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--key', help='reuse an existing access key instead of generating one')
    ap.add_argument('--base-url',
                    default='https://corindashs.eq.edu.au/ourcurriculum/TeachingAndLearning/Documents/PosEd',
                    help='site base URL, used to write the QLearn link list')
    args = ap.parse_args()

    access_key = args.key or make_key()
    salt = secrets.token_bytes(16)
    raw_key = derive(access_key, salt)

    pages = sorted(
        os.path.relpath(os.path.join(dirpath, name), SRC_DIR)
        for dirpath, _, names in os.walk(SRC_DIR)
        for name in names if name.endswith('.aspx'))
    assert pages, 'no staff pages found'

    if os.path.isdir(OUT_DIR):
        shutil.rmtree(OUT_DIR)

    built, canaries = [], []
    for rel in pages:
        src = os.path.join(SRC_DIR, rel)
        plain = open(src, 'rb').read()
        iv, ct = encrypt(plain, raw_key)

        page = (WRAPPER
                .replace('__PAYLOAD__', b64(ct))
                .replace('__SALT__', b64(salt))
                .replace('__IV__', b64(iv))
                .replace('__ITER__', str(ITERATIONS)))

        # A gated page must never contain server-side code or leak its content.
        assert '<%' not in page, '%s: server-side code block in wrapper' % rel
        for probe in (b'WEEKLY_WORDS', b'PUZZLES', b'const PASSWORD',
                      b'Home Group', b'character strength'):
            assert probe not in page.encode('utf-8'), \
                '%s: plaintext %r survived into the gated page' % (rel, probe)

        dst = os.path.join(OUT_DIR, rel)
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        open(dst, 'w', encoding='utf-8').write(page)
        built.append((rel, len(plain), len(page)))
        canaries.append(rel)

    # Copy the non-page files through untouched (they cannot be encrypted this
    # way, and none of them contain staff-only material).
    passthrough = []
    for dirpath, _, names in os.walk(SRC_DIR):
        for name in names:
            if name.endswith('.aspx'):
                continue
            rel = os.path.relpath(os.path.join(dirpath, name), SRC_DIR)
            dst = os.path.join(OUT_DIR, rel)
            os.makedirs(os.path.dirname(dst), exist_ok=True)
            shutil.copy2(os.path.join(dirpath, name), dst)
            passthrough.append(rel)

    links = {rel: '%s/staff/%s#k=%s' % (args.base_url, rel.replace(os.sep, '/'), access_key)
             for rel in canaries}
    with open(os.path.join(ROOT, 'dist', 'qlearn-links.json'), 'w', encoding='utf-8') as fh:
        json.dump({'accessKey': access_key, 'links': links}, fh, indent=2)

    # Human-readable list to paste into the QLearn course.
    titles = {}
    for rel in canaries:
        m = re.search(r'<title>(.*?)</title>',
                      open(os.path.join(SRC_DIR, rel), encoding='utf-8').read(), re.S)
        titles[rel] = re.sub(r'\s+', ' ', m.group(1)).strip() if m else rel

    groups = [('Home Group games', 'games/'),
              ('Home Group lessons', 'homegroup-lessons/'),
              ('Staff learning', 'staff-learning/'),
              ('Brain breaks', 'brain-breaks/'),
              ('Archive', 'archive/')]

    with open(os.path.join(ROOT, 'dist', 'qlearn-links.md'), 'w', encoding='utf-8') as fh:
        fh.write('# Staff links for QLearn\n\n')
        fh.write('**Access key: `%s`**\n\n' % access_key)
        fh.write('Paste these links into the QLearn course. Each one already carries the\n'
                 'access key, so staff clicking from QLearn go straight into the page with\n'
                 'nothing to type. List the access key on the QLearn page too, for anyone\n'
                 'who arrives at a page without using these links.\n\n')
        for label, prefix in groups:
            rels = [r for r in canaries if r.replace(os.sep, '/').startswith(prefix)]
            if not rels:
                continue
            fh.write('## %s\n\n' % label)
            for rel in sorted(rels):
                fh.write('- [%s](%s)\n' % (titles[rel], links[rel]))
            fh.write('\n')

    print('access key: %s' % access_key)
    print('iterations: %d   salt: %s' % (ITERATIONS, b64(salt)))
    print('')
    for rel, a, b in built:
        print('  %-46s %7d -> %7d bytes' % (rel, a, b))
    print('')
    print('%d pages gated, %d files copied through: %s'
          % (len(built), len(passthrough), ', '.join(passthrough)))
    print('output: %s' % OUT_DIR)


if __name__ == '__main__':
    main()
