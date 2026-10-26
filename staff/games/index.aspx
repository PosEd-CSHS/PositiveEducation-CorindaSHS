<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Home Group Games — Corinda SHS</title>
<style>
  @import url('../../assets/fonts/fonts.css');
  :root { --green:#00180f; --gold:#f2b400; --gold-dim:rgba(242,180,0,0.15); --gold-border:rgba(242,180,0,0.3); --white:#fdfdfd; --muted:rgba(255,255,255,0.6); }
  * { box-sizing:border-box; margin:0; padding:0; }
  body { font-family:'DM Sans',Arial,sans-serif; background:var(--green); color:var(--white); min-height:100vh; }
  .wrap { max-width:960px; margin:0 auto; padding:40px 20px 64px; }
  header { text-align:center; margin-bottom:32px; }
  .eyebrow { font-family:'DM Mono',monospace; font-size:11px; letter-spacing:.12em; text-transform:uppercase; color:var(--gold); margin-bottom:8px; }
  h1 { font-family:'Bebas Neue',Arial,sans-serif; font-size:clamp(32px,6vw,52px); letter-spacing:.02em; line-height:1.05; }
  .lede { max-width:560px; margin:14px auto 0; color:var(--muted); font-size:15px; line-height:1.55; }
  .section-head { display:flex; align-items:baseline; gap:10px; margin:0 0 14px; border-bottom:1px solid var(--gold-border); padding-bottom:8px; }
  .section-head h2 { font-family:'Bebas Neue',Arial,sans-serif; font-size:24px; letter-spacing:.02em; color:var(--gold); }
  .section-head span { font-size:12px; color:var(--muted); }
  section { margin-bottom:36px; }
  .grid { display:grid; grid-template-columns:repeat(auto-fill,minmax(250px,1fr)); gap:12px; }
  .card { display:block; background:rgba(255,255,255,.04); border:1px solid rgba(255,255,255,.1); border-radius:12px; padding:16px; text-decoration:none; color:var(--white); transition:border-color .15s, background .15s, transform .15s; }
  .card:hover { border-color:var(--gold-border); background:rgba(242,180,0,.06); transform:translateY(-2px); }
  .card-title { font-weight:700; font-size:15px; margin-bottom:4px; }
  .card-desc { font-size:13px; color:var(--muted); line-height:1.4; }
  .card-emoji { font-size:20px; margin-bottom:6px; display:block; }
  .new { font-size:9px; color:var(--green); background:var(--gold); padding:2px 7px; border-radius:3px; vertical-align:middle; }
  .lb { display:flex; flex-wrap:wrap; gap:10px; align-items:center; }
  .lb a { color:var(--gold); text-decoration:none; border:1px solid var(--gold-border); border-radius:20px; padding:6px 16px; font-size:13px; }
  .lb a.main { background:var(--gold); color:var(--green); font-weight:700; border-color:var(--gold); }
  .lb a:hover { background:var(--gold-dim); } .lb a.main:hover { background:#ffc61a; }
  footer { text-align:center; margin-top:40px; padding-top:20px; border-top:1px solid rgba(255,255,255,.1); font-size:12px; color:var(--muted); }
</style>
</head>
<body>
<div class="wrap">
  <header>
    <div class="eyebrow">Corinda State High School</div>
    <h1>Home Group Games</h1>
    <p class="lede">Select a game — it opens in this tab. Choose your house and group when it loads, and submit your score at the end.</p>
  </header>

  <section>
    <div class="section-head"><h2>Games</h2><span>whole-class, about 10 minutes</span></div>
    <div class="grid">
      <a class="card" href="weekly-trivia.aspx">
        <span class="card-emoji">🧠</span>
        <div class="card-title">Weekly Trivia <span class="new">NEW</span></div>
        <div class="card-desc">Ten rounds mixing this fortnight's focus, Crack the Code, a logo and general knowledge — some weeks add a music round or a shot at winning back a missed point.</div>
      </a>
      <a class="card" href="wordle.aspx">
        <span class="card-emoji">🟩</span>
        <div class="card-title">Wordle</div>
        <div class="card-desc">Guess the word of the week in six tries.</div>
      </a>
      <a class="card" href="connections.aspx">
        <span class="card-emoji">🔗</span>
        <div class="card-title">Connections</div>
        <div class="card-desc">Find the four groups of four words that belong together.</div>
      </a>
      <a class="card" href="wheel-of-fortune.aspx">
        <span class="card-emoji">🎡</span>
        <div class="card-title">Wheel of Fortune</div>
        <div class="card-desc">Solve the phrase one letter at a time. Work as a group.</div>
      </a>
      <a class="card" href="alphabucks.aspx">
        <span class="card-emoji">🔤</span>
        <div class="card-title">Alphabucks</div>
        <div class="card-desc">Name something for every category, starting with the letter of the week.</div>
      </a>
      <a class="card" href="smoulder.aspx">
        <span class="card-emoji">🔍</span>
        <div class="card-title">Where's Smoulder?</div>
        <div class="card-desc">Find the hidden phoenix in the scene before time runs out.</div>
      </a>
      <a class="card" href="stop-the-clock.aspx">
        <span class="card-emoji">⏱️</span>
        <div class="card-title">Stop the Clock</div>
        <div class="card-desc">Stop the timer as close to 5 seconds as you can.</div>
      </a>
      <a class="card" href="geoguessr.aspx">
        <span class="card-emoji">📍</span>
        <div class="card-title">Corinda GeoGuessr</div>
        <div class="card-desc">One photo from around the school each week. Pin where it was taken on the campus map, closest scores 10.</div>
      </a>
    </div>
  </section>

  <section>
    <div class="section-head"><h2>Leaderboards</h2><span>scores from the shared form</span></div>
    <div class="lb">
      <a class="main" href="leaderboard.aspx">🏆 All houses</a>
      <a href="leaderboard.aspx?house=Bunar">Bunar</a><a href="leaderboard.aspx?house=Dibbil">Dibbil</a><a href="leaderboard.aspx?house=Kabul">Kabul</a><a href="leaderboard.aspx?house=Moori">Moori</a><a href="leaderboard.aspx?house=Pirri">Pirri</a><a href="leaderboard.aspx?house=Yarraman">Yarraman</a>
    </div>
  </section>

  <footer>Corinda SHS · Positive Education</footer>
</div>
</body>
</html>
