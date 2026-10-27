<!DOCTYPE html>
<html lang="en-AU">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>Corinda GeoGuessr</title>

<script>
/* ==========================================================================
   CONFIG — everything you need to change is in this block.
   ========================================================================== */

const CONFIG = {

  // ---- The campus map image -------------------------------------------
  // Put your aerial screenshot next to this file, e.g. in a "map" folder.
  // Leave as null to run with the built-in placeholder map for testing.
  // Photos and the map live in the shared assets folder (both branches upload it).
  assetBase: "../../assets/geoguessr/",
  mapImage: "map/corinda-aerial.jpg",

  // How wide is the map image in real life, left edge to right edge, in metres?
  // Measure it once in Queensland Globe. Everything else scales from this.
  mapWidthMetres: 350,

  // Attribution line shown under the map. Required if you use QLD open data.
  mapCredit: "Aerial imagery © State of Queensland (CC BY 4.0)",

  // ---- Scoring (out of 10, matching every other game in the suite) ------
  // One photo per week. Each row is [furthest distance in metres, points].
  // The first row a guess fits inside decides the score; further than the
  // last row scores 0. "Exact" is 3 m because nobody can tap closer than that.
  scoreBands: [
    [3, 10], [5, 9], [10, 8], [15, 7], [20, 6],
    [25, 5], [30, 4], [35, 3], [40, 2], [50, 1]
  ],

  guessSeconds: 60,        // 0 = no timer

  // ---- Suite integration ----------------------------------------------
  // Weeks are worked out automatically from assets/site-config.js, like the other games.
  // If that file cannot be found, these dates are used instead. They are a copy of the
  // term dates in site-config.js, so update both at the annual rollover.
  fallbackTerms: [
    { t: 1, start: "2026-01-27", end: "2026-04-02" },
    { t: 2, start: "2026-04-20", end: "2026-06-26" },
    { t: 3, start: "2026-07-13", end: "2026-09-18" },
    { t: 4, start: "2026-10-06", end: "2026-12-11" }
  ],
  gameName: "GeoGuessr",
  lockPerWeek: true,       // one attempt per week per device (add ?test=1 to the address to bypass)

  form: {
    base: "https://forms.cloud.microsoft/Pages/ResponsePage.aspx",
    id: "xccAZrUWr0uekzI72MAduqpmcw_jVYVCjN05AfEP1IdUOUtFVUJQOFhZWjRZNjAzRkMyWlozTUpTUy4u",
    // Same form and field IDs as every other game in the suite.
    fields: {
      week:  "rb28fecc633264af694f45d8cf2b3b8c1",
      game:  "rdbbd457b83da425e93f978536b950482",
      house: "rd04d4cf9da8a4213820791f91cdcf6ba",
      group: "r3022db1950b649218496e706728c203f",
      score: "r8b61653d0854482a9e7e329026083f7b"
    }
  }
};

/* ==========================================================================
   ROUNDS — paste the block exported by Corinda GeoGuessr Builder.html
   x and y are fractions of the map image (0 = left/top, 1 = right/bottom).
   ========================================================================== */

let ROUNDS = [
  { photo: "photos/round-001.jpg", x: 0.0494, y: 0.1006, wp: 1, caption: "" },
  { photo: "photos/round-002.jpg", x: 0.3211, y: 0.2915, wp: 2, caption: "" },
  { photo: "photos/round-003.jpg", x: 0.3545, y: 0.5767, wp: 3, caption: "" },
  { photo: "photos/round-004.jpg", x: 0.6167, y: 0.1703, wp: 4, caption: "" },
  { photo: "photos/round-005.jpg", x: 0.8392, y: 0.275, wp: 5, caption: "" },
  { photo: "photos/round-006.jpg", x: 0.801, y: 0.4208, wp: 6, caption: "" },
  { photo: "photos/round-007.jpg", x: 0.7104, y: 0.6897, wp: 7, caption: "" },
  { photo: "photos/round-008.jpg", x: 0.7915, y: 0.6897, wp: 8, caption: "" },
  { photo: "photos/round-009.jpg", x: 0.9075, y: 0.9544, wp: 9, caption: "" },
  { photo: "photos/round-010.jpg", x: 0.6882, y: 0.8374, wp: 10, caption: "" },
  { photo: "photos/round-011.jpg", x: 0.7454, y: 0.7677, wp: 11, caption: "" },
  { photo: "photos/round-012.jpg", x: 0.5293, y: 0.8723, wp: 12, caption: "" },
  { photo: "photos/round-013.jpg", x: 0.4785, y: 0.6958, wp: 13, caption: "" },
  { photo: "photos/round-014.jpg", x: 0.4773, y: 0.7553, wp: 14, caption: "" },
  { photo: "photos/round-015.jpg", x: 0.4149, y: 0.743, wp: 15, caption: "" },
  { photo: "photos/round-016.jpg", x: 0.3783, y: 0.9339, wp: 16, caption: "" },
  { photo: "photos/round-017.jpg", x: 0.3879, y: 0.8477, wp: 17, caption: "" },
  { photo: "photos/round-018.jpg", x: 0.4133, y: 0.8107, wp: 18, caption: "" },
  { photo: "photos/round-019.jpg", x: 0.3132, y: 0.6671, wp: 19, caption: "" },
  { photo: "photos/round-020.jpg", x: 0.2703, y: 0.5193, wp: 20, caption: "" },
  { photo: "photos/round-021.jpg", x: 0.2703, y: 0.8046, wp: 21, caption: "" },
  { photo: "photos/round-022.jpg", x: 0.2655, y: 0.6527, wp: 22, caption: "" },
  { photo: "photos/round-023.jpg", x: 0.1717, y: 0.5419, wp: 23, caption: "" },
  { photo: "photos/round-024.jpg", x: 0.1829, y: 0.4536, wp: 24, caption: "" },
  { photo: "photos/round-025.jpg", x: 0.1765, y: 0.3489, wp: 25, caption: "" },
  { photo: "photos/round-026.jpg", x: 0.1431, y: 0.2607, wp: 26, caption: "" },
  { photo: "photos/round-027.jpg", x: 0.1209, y: 0.5213, wp: 27, caption: "" },
  { photo: "photos/round-028.jpg", x: 0.1273, y: 0.9113, wp: 28, caption: "" },
  { photo: "photos/round-029.jpg", x: 0.0411, y: 0.9201, wp: 29, caption: "" },
  { photo: "photos/round-030.jpg", x: 0.0589, y: 0.8929, wp: 30, caption: "" },
  { photo: "photos/round-031.jpg", x: 0.3434, y: 0.2442, wp: 31, caption: "" },
  { photo: "photos/round-032.jpg", x: 0.6962, y: 0.3838, wp: 32, caption: "" },
  { photo: "photos/round-033.jpg", x: 0.2051, y: 0.119, wp: 33, caption: "" },
  { photo: "photos/round-034.jpg", x: 0.453, y: 0.1334, wp: 34, caption: "" },
  { photo: "photos/round-035.jpg", x: 0.8869, y: 0.0493, wp: 35, caption: "" },
  { photo: "photos/round-036.jpg", x: 0.89, y: 0.1642, wp: 36, caption: "" },
  { photo: "photos/round-037.jpg", x: 0.0558, y: 0.8436, wp: 37, caption: "" },
  { photo: "photos/round-038.jpg", x: 0.1479, y: 0.8333, wp: 38, caption: "" },
  { photo: "photos/round-039.jpg", x: 0.0494, y: 0.626, wp: 39, caption: "" },
  { photo: "photos/round-040.jpg", x: 0.0891, y: 0.6076, wp: 40, caption: "" },
  { photo: "photos/round-041.jpg", x: 0.1304, y: 0.4331, wp: 41, caption: "" },
  { photo: "photos/round-042.jpg", x: 0.2719, y: 0.4331, wp: 42, caption: "" },
  { photo: "photos/round-043.jpg", x: 0.5452, y: 0.6896, wp: 43, caption: "" },
  { photo: "photos/round-044.jpg", x: 0.5945, y: 0.6486, wp: 44, caption: "" },
  { photo: "photos/round-045.jpg", x: 0.2671, y: 0.7615, wp: 45, caption: "" },
  { photo: "photos/round-046.jpg", x: 0.3164, y: 0.8436, wp: 46, caption: "" },
  { photo: "photos/round-047.jpg", x: 0.2909, y: 0.9483, wp: 47, caption: "" },
  { photo: "photos/round-048.jpg", x: 0.1702, y: 0.9647, wp: 48, caption: "" },
  { photo: "photos/round-049.jpg", x: 0.8328, y: 0.5767, wp: 49, caption: "" },
  { photo: "photos/round-050.jpg", x: 0.1606, y: 0.6404, wp: 50, caption: "" },
];

const HOUSES = ["Bunar", "Dibbil", "Kabul", "Moori", "Pirri", "Yarraman"];
const GROUPS = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","Staff"];
</script>

<script src="../../assets/site-config.js"></script>
<style>
@import url('../../assets/fonts/fonts.css');
:root{
  --ink:#00180f;
  --ink-2:#032a1a;
  --ink-3:#064029;
  --gold:#f2b400;
  --gold-dim:#a87d06;
  --paper:#f6f4ec;
  --muted:#8fae9e;
  --hot:#e8593a;
}
*{box-sizing:border-box;-webkit-tap-highlight-color:transparent}
html,body{margin:0;height:100%}
body{
  background:var(--ink);
  color:var(--paper);
  font-family:"DM Sans",system-ui,-apple-system,sans-serif;
  font-size:16px;
  line-height:1.5;
  overscroll-behavior:none;
}
h1,h2,.display{
  font-family:"Bebas Neue","Arial Narrow",sans-serif;
  font-weight:400;
  letter-spacing:.02em;
  line-height:.95;
  margin:0;
}
.mono{font-family:"DM Mono",ui-monospace,monospace;font-variant-numeric:tabular-nums}

.app{max-width:640px;margin:0 auto;min-height:100%;display:flex;flex-direction:column;padding:16px}
.screen{display:none;flex:1;flex-direction:column}
.screen.on{display:flex}

[hidden]{display:none !important}
button{font:inherit;cursor:pointer;border:0}
.btn{
  display:block;width:100%;padding:15px 18px;border-radius:2px;
  background:var(--gold);color:var(--ink);
  font-weight:700;font-size:17px;
}
.btn:disabled{background:var(--ink-3);color:var(--muted);cursor:not-allowed}
.btn.ghost{background:transparent;color:var(--gold);box-shadow:inset 0 0 0 1px var(--ink-3)}
.btn:focus-visible,select:focus-visible{outline:2px solid var(--gold);outline-offset:2px}

label{display:block;font-size:13px;color:var(--muted);margin:18px 0 6px}
select{
  width:100%;padding:13px;border-radius:2px;font:inherit;
  background:var(--ink-2);color:var(--paper);
  border:1px solid var(--ink-3);
}

/* --- title --- */
.title{font-size:clamp(52px,17vw,86px);color:var(--gold)}
.sub{color:var(--muted);font-size:15px;margin:10px 0 4px;max-width:44ch}
.rule{height:1px;background:var(--ink-3);margin:22px 0}

/* --- play header --- */
.bar{display:flex;justify-content:space-between;align-items:baseline;gap:12px;margin-bottom:12px}
.bar .display{font-size:26px;color:var(--gold)}
.timer{font-size:15px;color:var(--muted)}
.timer.low{color:var(--hot)}

/* --- photo --- */
.photo-wrap{
  position:relative;width:100%;aspect-ratio:4/3;background:var(--ink-2);
  border:1px solid var(--ink-3);overflow:hidden;
}
.photo-wrap img{width:100%;height:100%;object-fit:cover;display:block}
.caption{font-size:13px;color:var(--muted);margin-top:8px;min-height:1.2em}

/* --- map --- */
.map-sheet{
  position:fixed;inset:0;background:var(--ink);z-index:40;
  display:none;flex-direction:column;padding:12px;
}
.map-sheet.on{display:flex}
.map-head{display:flex;justify-content:space-between;align-items:center;margin-bottom:10px}
.map-head .display{font-size:22px;color:var(--gold)}
.close{background:none;color:var(--muted);font-size:15px;padding:6px}

.map-view{
  position:relative;flex:1;overflow:hidden;background:var(--ink-2);
  border:1px solid var(--ink-3);touch-action:none;cursor:crosshair;
}
.map-layer{position:absolute;top:0;left:0;transform-origin:0 0}
.map-layer img{display:block;width:100%;user-select:none;-webkit-user-drag:none}
.map-layer svg.overlay{position:absolute;inset:0;width:100%;height:100%;overflow:visible;pointer-events:none}

/* --- play: photo and map on one screen --- */
body.playing .app{height:100vh;height:100dvh;min-height:0;max-width:1100px}
#s-play{min-height:0}
.play-grid{display:flex;flex-direction:column;gap:10px;flex:1;min-height:0}
.play-photo{flex:none;aspect-ratio:auto;height:30vh;height:30dvh;background:#000;cursor:zoom-in}
.play-photo img,.photo-wrap img.contain{object-fit:contain}
.zoomtag{position:absolute;right:6px;bottom:6px;background:rgba(0,24,15,.78);color:var(--paper);font-size:11px;padding:2px 7px;border-radius:2px;pointer-events:none}
.play-map{flex:1;min-height:0;display:flex;flex-direction:column}
.map-sheet.inline{position:static;inset:auto;z-index:auto;padding:0;background:transparent;flex:1;min-height:0}
.map-sheet.inline .map-head{display:none}
.map-sheet.inline .map-view{min-height:180px}
.map-sheet.inline .credit{margin-top:4px}
.map-sheet.inline .hint{margin-top:4px}
.map-sheet.inline .map-actions{margin-top:6px}
#s-play .caption{margin:6px 0 0;min-height:0}
@media(min-width:900px){
  .play-grid{flex-direction:row}
  .play-photo{flex:0 0 46%;height:auto;aspect-ratio:4/3;align-self:flex-start}
}
@media(max-height:560px) and (orientation:landscape){
  .play-grid{flex-direction:row}
  .play-photo{flex:0 0 42%;height:auto;aspect-ratio:4/3;align-self:flex-start}
}
#lightbox{position:fixed;inset:0;background:rgba(0,0,0,.94);z-index:60;display:flex;align-items:center;justify-content:center;cursor:zoom-out}
#lightbox img{max-width:100%;max-height:100%;object-fit:contain}
.credit{font-size:11px;color:var(--muted);margin-top:6px;text-align:right}
.map-actions{margin-top:10px;display:flex;gap:8px}
.map-actions .btn{flex:1}
.hint{font-size:13px;color:var(--muted);margin-top:8px;text-align:center}

/* --- result --- */
.metric{display:flex;justify-content:space-between;padding:11px 0;border-bottom:1px solid var(--ink-3)}
.metric span:last-child{color:var(--gold)}
.big{font-size:clamp(64px,22vw,110px);color:var(--gold);margin:8px 0}
.scale{font-size:14px;color:var(--muted)}

.rows{margin:16px 0}
.row{display:flex;justify-content:space-between;align-items:baseline;padding:9px 0;border-bottom:1px solid var(--ink-3);font-size:15px}
.row .d{color:var(--muted);font-size:13px}

.note{background:var(--ink-2);border-left:2px solid var(--gold);padding:12px 14px;font-size:14px;margin:16px 0}

/* --- builder --- */
.builder .strip{display:flex;gap:8px;overflow-x:auto;padding:8px 0}
.builder .thumb{width:70px;height:52px;object-fit:cover;border:2px solid transparent;flex:none}
.builder .thumb.sel{border-color:var(--gold)}
.builder .thumb.done{opacity:.4}
textarea{
  width:100%;height:180px;background:var(--ink-2);color:var(--paper);
  border:1px solid var(--ink-3);font-family:"DM Mono",monospace;font-size:12px;padding:10px;
}
input[type=file]{font-size:13px;color:var(--muted);margin:8px 0}
</style>
</head>
<body>
<div class="app">

<!-- ============ SIGN IN ============ -->
<section id="s-start" class="screen on">
  <h1 class="title">Corinda<br>GeoGuessr</h1>
  <p class="sub">One photo from around the school each week. Drop a pin where you think it was taken. The closer you get, the more you score, up to 10.</p>
  <div class="rule"></div>
  <label for="house">House</label>
  <select id="house"></select>
  <label for="group">Homegroup</label>
  <select id="group"></select>
  <div style="flex:1"></div>
  <p id="lockmsg" class="sub" hidden></p>
  <button class="btn" id="begin" style="margin-top:20px">Show me this week's photo</button>
</section>

<!-- ============ PLAY ============ -->
<section id="s-play" class="screen">
  <div class="bar">
    <span class="display" id="roundlabel">This week's photo</span>
    <span class="timer mono" id="timer"></span>
  </div>
  <div class="play-grid">
    <div class="photo-wrap play-photo" id="photobox" role="button" tabindex="0" aria-label="Enlarge photo">
      <img id="photo" alt="A place somewhere at Corinda State High School">
      <span class="zoomtag">Tap to enlarge</span>
    </div>
    <div class="play-map" id="playmap"></div>
  </div>
  <p class="caption" id="caption"></p>
</section>

<!-- ============ RESULT ============ -->
<section id="s-reveal" class="screen">
  <h2 class="display" style="font-size:34px">Your result</h2>
  <div class="big display mono" id="final">0</div>
  <p class="scale">out of 10</p>
  <div class="photo-wrap" style="margin-top:12px"><img class="contain" id="revealphoto" alt=""></div>
  <div class="metric"><span>You were off by</span><span class="mono" id="dist">&mdash;</span></div>
  <p class="note" id="verdict"></p>
  <p class="caption" id="revealcaption"></p>
  <div style="flex:1"></div>
  <button class="btn ghost" id="seemap" style="margin-bottom:8px">Show me on the map</button>
  <button class="btn" id="submit">Submit score for <span id="housename">your house</span></button>
  <p class="hint">Opens a form with your score already filled in. Press Submit on that page to count it.</p>
</section>

<!-- ============ BUILDER ============ -->
<section id="s-builder" class="screen builder">
  <h2 class="display" style="font-size:32px;color:var(--gold)">Builder</h2>
  <p class="sub">Load your photos, tap one, then tap the map where it was taken. Repeat. Copy the code out at the end.</p>
  <input type="file" id="files" accept="image/*" multiple>
  <div class="strip" id="strip"></div>
  <button class="btn" id="bmap">Open map and place selected photo</button>
  <label for="out">Paste this into the ROUNDS list in the file</label>
  <textarea id="out" readonly spellcheck="false"></textarea>
  <button class="btn ghost" id="copy" style="margin-top:8px">Copy code</button>
</section>

</div>

<div id="lightbox" hidden><img id="lightimg" alt=""></div>

<!-- ============ MAP SHEET (shared) ============ -->
<div class="map-sheet" id="sheet">
  <div class="map-head">
    <span class="display" id="sheettitle">Where was it taken?</span>
    <button class="close" id="sheetclose">Close</button>
  </div>
  <div class="map-view" id="mapview">
    <div class="map-layer" id="maplayer">
      <img id="mapimg" alt="Map of the Corinda State High School campus">
      <svg class="overlay" id="overlay"></svg>
    </div>
  </div>
  <p class="credit" id="credit"></p>
  <p class="hint" id="maphint">Drag to move. Pinch to zoom. Tap to drop your pin.</p>
  <div class="map-actions">
    <button class="btn" id="confirm" disabled>Confirm pin</button>
  </div>
</div>

<script>
/* ==========================================================================
   Storage that degrades gracefully if localStorage is unavailable.
   ========================================================================== */
const store = (() => {
  const mem = {};
  let ok = true;
  try { localStorage.setItem("__t","1"); localStorage.removeItem("__t"); }
  catch (e) { ok = false; }
  return {
    get: k => { try { return ok ? localStorage.getItem(k) : mem[k] ?? null; } catch { return mem[k] ?? null; } },
    set: (k,v) => { try { ok ? localStorage.setItem(k,v) : (mem[k]=v); } catch { mem[k]=v; } }
  };
})();

/* ==========================================================================
   Placeholder assets so the game runs before you add real ones.
   ========================================================================== */
function placeholderMap(){
  const s = `<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="900" viewBox="0 0 1200 900">
    <rect width="1200" height="900" fill="#123a26"/>
    <rect x="90" y="90" width="300" height="170" fill="#4a5b52"/>
    <rect x="440" y="90" width="220" height="170" fill="#4a5b52"/>
    <rect x="90" y="330" width="200" height="260" fill="#57685e"/>
    <rect x="350" y="360" width="330" height="150" fill="#4a5b52"/>
    <rect x="760" y="120" width="330" height="480" rx="140" fill="#2f6b41"/>
    <rect x="120" y="660" width="480" height="180" fill="#6d6152"/>
    <rect x="700" y="680" width="380" height="160" fill="#4a5b52"/>
    <g stroke="#8fae9e" stroke-width="3" opacity=".5" fill="none">
      <path d="M60 300 H1140"/><path d="M320 60 V860"/>
    </g>
    <text x="600" y="470" fill="#8fae9e" font-family="sans-serif" font-size="26"
      text-anchor="middle">placeholder map — replace with your aerial</text>
  </svg>`;
  return "data:image/svg+xml;charset=utf-8," + encodeURIComponent(s);
}
function placeholderPhoto(n){
  const s = `<svg xmlns="http://www.w3.org/2000/svg" width="800" height="600" viewBox="0 0 800 600">
    <rect width="800" height="600" fill="#032a1a"/>
    <text x="400" y="285" fill="#f2b400" font-family="sans-serif" font-size="64"
      text-anchor="middle">Photo ${n}</text>
    <text x="400" y="335" fill="#8fae9e" font-family="sans-serif" font-size="22"
      text-anchor="middle">replace me</text>
  </svg>`;
  return "data:image/svg+xml;charset=utf-8," + encodeURIComponent(s);
}

/* ==========================================================================
   Map sheet: pan, pinch zoom, tap to pin.
   ========================================================================== */
const sheet   = document.getElementById("sheet");
const view    = document.getElementById("mapview");
const layer   = document.getElementById("maplayer");
const mapimg  = document.getElementById("mapimg");
const overlay = document.getElementById("overlay");
const confirmBtn = document.getElementById("confirm");

let tx = 0, ty = 0, scale = 1, baseW = 0, baseH = 0;
let pin = null;            // {x,y} normalised 0-1
let sheetMode = "guess";   // guess | reveal | build
let onConfirm = null;

mapimg.src = CONFIG.mapImage ? CONFIG.assetBase + CONFIG.mapImage : placeholderMap();
document.getElementById("credit").textContent = CONFIG.mapImage ? CONFIG.mapCredit : "";

function fitMap(){
  const vw = view.clientWidth, vh = view.clientHeight;
  const ar = (mapimg.naturalWidth || 4) / (mapimg.naturalHeight || 3);
  baseW = vw; baseH = vw / ar;
  if (baseH > vh) { baseH = vh; baseW = vh * ar; }
  mapimg.style.width = baseW + "px";
  scale = 1;
  tx = (vw - baseW) / 2;
  ty = (vh - baseH) / 2;
  apply();
}
function apply(){
  layer.style.transform = `translate(${tx}px,${ty}px) scale(${scale})`;
  overlay.setAttribute("viewBox", `0 0 ${baseW} ${baseH}`);
  overlay.style.width = baseW + "px";
  overlay.style.height = baseH + "px";
}
mapimg.addEventListener("load", fitMap);
if (mapimg.complete && mapimg.naturalWidth) fitMap();
window.addEventListener("resize", () => { if (sheet.classList.contains("on")) fitMap(); });

function viewToNorm(clientX, clientY){
  const r = view.getBoundingClientRect();
  const x = ((clientX - r.left) - tx) / scale / baseW;
  const y = ((clientY - r.top)  - ty) / scale / baseH;
  return { x: Math.min(1, Math.max(0, x)), y: Math.min(1, Math.max(0, y)) };
}

function drawMarks(marks, line){
  let svg = "";
  if (line) {
    svg += `<line x1="${line[0].x*baseW}" y1="${line[0].y*baseH}"
             x2="${line[1].x*baseW}" y2="${line[1].y*baseH}"
             stroke="#f2b400" stroke-width="2" stroke-dasharray="6 5"/>`;
  }
  for (const m of marks) {
    const cx = m.x * baseW, cy = m.y * baseH;
    const col = m.kind === "answer" ? "#e8593a" : "#f2b400";
    svg += `<circle cx="${cx}" cy="${cy}" r="9" fill="${col}" stroke="#00180f" stroke-width="2.5"/>`;
    if (m.kind === "answer")
      svg += `<circle cx="${cx}" cy="${cy}" r="17" fill="none" stroke="${col}" stroke-width="2" opacity=".55"/>`;
  }
  overlay.innerHTML = svg;
}

/* pointer handling */
const pointers = new Map();
let startDist = 0, startScale = 1, moved = 0, downAt = 0;

view.addEventListener("pointerdown", e => {
  view.setPointerCapture(e.pointerId);
  pointers.set(e.pointerId, { x: e.clientX, y: e.clientY });
  if (pointers.size === 1) { moved = 0; downAt = Date.now(); }
  if (pointers.size === 2) {
    const [a,b] = [...pointers.values()];
    startDist = Math.hypot(a.x-b.x, a.y-b.y);
    startScale = scale;
  }
});
view.addEventListener("pointermove", e => {
  if (!pointers.has(e.pointerId)) return;
  const prev = pointers.get(e.pointerId);
  const dx = e.clientX - prev.x, dy = e.clientY - prev.y;
  pointers.set(e.pointerId, { x: e.clientX, y: e.clientY });

  if (pointers.size === 1) {
    moved += Math.hypot(dx, dy);
    tx += dx; ty += dy; apply();
  } else if (pointers.size === 2) {
    const [a,b] = [...pointers.values()];
    const d = Math.hypot(a.x-b.x, a.y-b.y);
    const next = Math.min(6, Math.max(1, startScale * (d / startDist)));
    const r = view.getBoundingClientRect();
    const mx = (a.x + b.x)/2 - r.left, my = (a.y + b.y)/2 - r.top;
    tx = mx - (mx - tx) * (next/scale);
    ty = my - (my - ty) * (next/scale);
    scale = next; apply();
    moved = 999;
  }
});
function endPointer(e){
  if (pointers.size === 1 && moved < 8 && Date.now() - downAt < 500 && sheetMode !== "reveal") {
    pin = viewToNorm(e.clientX, e.clientY);
    drawMarks([{ ...pin, kind: "guess" }]);
    confirmBtn.disabled = false;
  }
  pointers.delete(e.pointerId);
}
view.addEventListener("pointerup", endPointer);
view.addEventListener("pointercancel", e => pointers.delete(e.pointerId));
view.addEventListener("wheel", e => {
  e.preventDefault();
  const next = Math.min(6, Math.max(1, scale * (e.deltaY < 0 ? 1.12 : 0.89)));
  const r = view.getBoundingClientRect();
  const mx = e.clientX - r.left, my = e.clientY - r.top;
  tx = mx - (mx - tx) * (next/scale);
  ty = my - (my - ty) * (next/scale);
  scale = next; apply();
}, { passive: false });

function openSheet(mode, opts = {}){
  sheetMode = mode;
  pin = null;
  overlay.innerHTML = "";
  const inline = !!opts.inline;
  sheet.classList.toggle("inline", inline);
  (inline ? $("playmap") : document.body).appendChild(sheet);
  sheet.classList.add("on");
  document.getElementById("sheettitle").textContent = opts.title || "Where was it taken?";
  document.getElementById("maphint").textContent = opts.hint || "Drag to move. Pinch to zoom. Tap to drop your pin.";
  confirmBtn.textContent = opts.confirmLabel || "Confirm pin";
  confirmBtn.disabled = !opts.marks;
  onConfirm = opts.onConfirm || (() => closeSheet());
  requestAnimationFrame(() => {
    fitMap();
    if (opts.marks) drawMarks(opts.marks, opts.line);
  });
}
function closeSheet(){
  sheet.classList.remove("on", "inline");
  document.body.appendChild(sheet);      // park it outside the play screen
}
document.getElementById("sheetclose").addEventListener("click", closeSheet);
confirmBtn.addEventListener("click", () => onConfirm && onConfirm());

/* ==========================================================================
   Scoring: distance in metres -> points out of 10
   ========================================================================== */
function distanceMetres(a, b){
  const ar = (mapimg.naturalWidth || 4) / (mapimg.naturalHeight || 3);
  const dx = (a.x - b.x) * CONFIG.mapWidthMetres;
  const dy = (a.y - b.y) * (CONFIG.mapWidthMetres / ar);
  return Math.hypot(dx, dy);
}
function scoreFor(d){
  for (const [maxM, pts] of CONFIG.scoreBands) if (d <= maxM) return pts;
  return 0;
}

/* ==========================================================================
   This week's photo
   ========================================================================== */
const $ = id => document.getElementById(id);
const params = new URLSearchParams(location.search);
const TEST = params.has("test");

/* Same week rule as the other games: the latest term-week whose Monday is on
   or before today; holidays hold the most recent week. abs runs 1..40. */
function weekInfo(){
  try {
    const terms = (window.CSHS_SITE_CONFIG && window.CSHS_SITE_CONFIG.terms) || CONFIG.fallbackTerms;
    const parse = s => { const [y,m,d] = s.split("-").map(Number); return new Date(y,m-1,d); };
    const mondayOf = d => { const x = new Date(d); x.setDate(x.getDate() - (x.getDay()+6)%7); x.setHours(0,0,0,0); return x; };
    const today = new Date(); today.setHours(0,0,0,0);
    const sched = [];
    let abs = 0;
    for (const term of terms) {
      const end = parse(term.end); let mon = mondayOf(parse(term.start)); let w = 1;
      while (mon <= end) { abs++; sched.push({ t: term.t, w, abs, mon: new Date(mon) }); mon = new Date(mon); mon.setDate(mon.getDate()+7); w++; }
    }
    let chosen = sched[0];
    const force = parseInt(params.get("week"), 10);      // ?week=12 previews week 12
    if (force >= 1 && force <= sched.length) chosen = sched[force - 1];
    else for (const wk of sched) { if (wk.mon <= today) chosen = wk; else break; }
    return { label: `Term ${chosen.t} · Week ${chosen.w}`, abs: chosen.abs };
  } catch (e) { return { label: "Week unknown", abs: parseInt(params.get("week"), 10) || 1 }; }
}
const WEEK = weekInfo();

/* A fixed shuffle (same for every device, every year) so neighbouring weeks
   are not neighbouring waypoints. Week N always gets the same photo. */
function shuffled(list){
  const a = [...list]; let seed = 2026;
  const rnd = () => { seed |= 0; seed = seed + 0x6D2B79F5 | 0; let t = Math.imul(seed ^ seed >>> 15, 1 | seed);
    t = t + Math.imul(t ^ t >>> 7, 61 | t) ^ t; return ((t ^ t >>> 14) >>> 0) / 4294967296; };
  for (let i = a.length - 1; i > 0; i--) { const j = Math.floor(rnd() * (i + 1)); [a[i], a[j]] = [a[j], a[i]]; }
  return a;
}
function thisWeeksPhoto(){
  if (!ROUNDS.length) return { photo: placeholderPhoto(1), x: 0.5, y: 0.5, caption: "" };
  const order = shuffled(ROUNDS);
  return order[(WEEK.abs - 1) % order.length];
}

function show(id){
  document.querySelectorAll(".screen").forEach(s => s.classList.remove("on"));
  $(id).classList.add("on");
  document.body.classList.toggle("playing", id === "s-play");
}

HOUSES.forEach(h => $("house").add(new Option(h, h)));
GROUPS.forEach(g => $("group").add(new Option(g === "Staff" ? "Staff" : "Homegroup " + g, g)));
$("house").value = store.get("house") || "Moori";
$("group").value = store.get("group") || "A";

const lockKey = `geo-${WEEK.label}`;
const played = CONFIG.lockPerWeek && !TEST ? store.get(lockKey) : null;
if (played !== null) {
  $("lockmsg").hidden = false;
  $("lockmsg").textContent = `You've already played this week and scored ${played} out of 10. A new photo arrives next week.`;
  $("begin").disabled = true;
}

let round = null, guessPin = null, ticker = null, finalScore = 0, last = null;

function formatDist(d){
  return d < 10 ? d.toFixed(1) + " m" : Math.round(d) + " m";
}

$("begin").addEventListener("click", () => {
  store.set("house", $("house").value);
  store.set("group", $("group").value);
  round = { ...thisWeeksPhoto() };
  if (!round.photo.startsWith("data:")) round.photo = CONFIG.assetBase + round.photo;
  pin = null;
  $("photo").src = round.photo;
  $("caption").textContent = round.caption || "";
  show("s-play");
  openSheet("guess", {
    inline: true,
    hint: "Drag to move. Pinch or scroll to zoom. Tap to drop your pin.",
    confirmLabel: "Confirm pin",
    onConfirm: () => submitGuess(pin)
  });
  startTimer();
});

/* tap the photo to see it full size */
function openLight(){ $("lightimg").src = round.photo; $("lightbox").hidden = false; }
$("photobox").addEventListener("click", openLight);
$("photobox").addEventListener("keydown", e => { if (e.key === "Enter" || e.key === " ") { e.preventDefault(); openLight(); } });
$("lightbox").addEventListener("click", () => { $("lightbox").hidden = true; });

function startTimer(){
  clearInterval(ticker);
  if (!CONFIG.guessSeconds) { $("timer").textContent = ""; return; }
  let left = CONFIG.guessSeconds;
  const paint = () => {
    $("timer").textContent = left + "s";
    $("timer").classList.toggle("low", left <= 10);
  };
  paint();
  ticker = setInterval(() => {
    left--; paint();
    if (left <= 0) { clearInterval(ticker); submitGuess(pin); }
  }, 1000);
}

function submitGuess(guess){
  clearInterval(ticker);
  closeSheet();
  const answer = { x: round.x, y: round.y };
  const d = guess ? distanceMetres(guess, answer) : null;
  finalScore = guess ? scoreFor(d) : 0;
  last = { guess, answer };
  if (CONFIG.lockPerWeek && !TEST) store.set(lockKey, String(finalScore));

  $("final").textContent = finalScore;
  $("revealphoto").src = round.photo;
  $("revealcaption").textContent = round.caption || "";
  $("dist").textContent = guess ? formatDist(d) : "No pin placed";
  $("verdict").textContent =
    !guess          ? "No pin, no points. Next week's photo is waiting." :
    finalScore >= 9 ? "You could find your way around here blindfolded." :
    finalScore >= 6 ? "Solid. You know this part of the school." :
    finalScore >= 3 ? "In the right area, anyway." :
                      "Have you considered a school tour?";
  $("housename").textContent = $("house").value;
  $("seemap").hidden = !guess;
  show("s-reveal");
}

$("seemap").addEventListener("click", () => {
  openSheet("reveal", {
    title: "Here's where it was",
    hint: "Gold is your pin. Red is the real spot.",
    confirmLabel: "Got it",
    marks: [{ ...last.guess, kind: "guess" }, { ...last.answer, kind: "answer" }],
    line: [last.guess, last.answer],
    onConfirm: closeSheet
  });
});

$("submit").addEventListener("click", () => {
  const f = CONFIG.form.fields, house = $("house").value, grp = $("group").value;
  const q = new URLSearchParams();
  q.set("id", CONFIG.form.id);
  q.set(f.week,  WEEK.label);
  q.set(f.game,  CONFIG.gameName);
  q.set(f.house, house);
  q.set(f.group, grp === "Staff" ? "Staff" : house + " " + grp);
  q.set(f.score, String(finalScore));
  // URLSearchParams writes spaces as "+", which Microsoft Forms stores literally.
  window.open(CONFIG.form.base + "?" + q.toString().replace(/\+/g, "%20"), "_blank");
});

/* ==========================================================================
   Builder mode  —  open with ?builder=1
   ========================================================================== */
if (new URLSearchParams(location.search).has("builder")) {
  show("s-builder");
  const placed = [];
  let sel = -1, loaded = [];

  $("files").addEventListener("change", e => {
    loaded = [...e.target.files].map(f => ({ name: f.name, url: URL.createObjectURL(f) }));
    $("strip").innerHTML = "";
    loaded.forEach((f, i) => {
      const img = document.createElement("img");
      img.className = "thumb"; img.src = f.url; img.alt = f.name;
      img.addEventListener("click", () => {
        sel = i;
        [...$("strip").children].forEach((c, j) => c.classList.toggle("sel", j === i));
      });
      $("strip").appendChild(img);
    });
    sel = 0;
    if ($("strip").firstChild) $("strip").firstChild.classList.add("sel");
  });

  $("bmap").addEventListener("click", () => {
    if (sel < 0) { alert("Pick a photo from the strip first."); return; }
    openSheet("build", {
      title: loaded[sel].name,
      hint: "Tap the exact spot this photo was taken from.",
      confirmLabel: "Save this location",
      onConfirm: () => {
        if (!pin) return;
        const existing = placed.findIndex(p => p.photo.endsWith(loaded[sel].name));
        const entry = { photo: "photos/" + loaded[sel].name, x: +pin.x.toFixed(4), y: +pin.y.toFixed(4), caption: "" };
        existing >= 0 ? placed[existing] = entry : placed.push(entry);
        $("strip").children[sel].classList.add("done");
        closeSheet();
        render();
        if (sel < loaded.length - 1) {
          sel++;
          [...$("strip").children].forEach((c, j) => c.classList.toggle("sel", j === sel));
        }
      }
    });
  });

  function render(){
    $("out").value = "let ROUNDS = [\n" +
      placed.map(p => `  { photo: "${p.photo}", x: ${p.x}, y: ${p.y}, caption: "" },`).join("\n") +
      "\n];";
  }
  render();

  $("copy").addEventListener("click", async () => {
    try { await navigator.clipboard.writeText($("out").value); $("copy").textContent = "Copied"; }
    catch { $("out").select(); $("copy").textContent = "Select and copy manually"; }
    setTimeout(() => $("copy").textContent = "Copy code", 2000);
  });
}
</script>
</body>
</html>
