<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Home Group Helpers — Corinda SHS</title>
<style>
  @import url('../assets/fonts/fonts.css');
  :root { --green:#00180f; --gold:#f2b400; --gold-border:rgba(242,180,0,0.3); --white:#fdfdfd; --muted:rgba(255,255,255,0.65); }
  * { box-sizing:border-box; margin:0; padding:0; }
  body { font-family:'DM Sans',Arial,sans-serif; background:var(--green); color:var(--white); min-height:100vh; }
  .wrap { max-width:760px; margin:0 auto; padding:48px 20px 64px; }
  header { text-align:center; margin-bottom:34px; }
  .eyebrow { font-family:'DM Mono',monospace; font-size:11px; letter-spacing:.12em; text-transform:uppercase; color:var(--gold); margin-bottom:8px; }
  h1 { font-family:'Bebas Neue',Arial,sans-serif; font-size:clamp(38px,8vw,64px); letter-spacing:.02em; line-height:1.05; }
  .lede { max-width:520px; margin:14px auto 0; color:var(--muted); font-size:16px; line-height:1.55; }
  .grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(260px,1fr)); gap:16px; }
  .card { display:block; background:rgba(255,255,255,.05); border:1px solid rgba(255,255,255,.12); border-radius:14px; padding:26px 22px; text-decoration:none; color:var(--white); transition:border-color .15s, background .15s, transform .15s; }
  .card:hover, .card:focus-visible { border-color:var(--gold); background:rgba(242,180,0,.08); transform:translateY(-2px); outline:none; }
  .emoji { font-size:34px; display:block; margin-bottom:10px; }
  .title { font-family:'Bebas Neue',Arial,sans-serif; font-size:30px; letter-spacing:.03em; color:var(--gold); }
  .desc { font-size:14px; color:var(--muted); line-height:1.5; margin-top:4px; }
  .tips { margin-top:30px; border:1px solid var(--gold-border); border-radius:12px; padding:18px 22px; background:rgba(242,180,0,.06); }
  .tips h2 { font-family:'DM Mono',monospace; font-size:11px; letter-spacing:.12em; text-transform:uppercase; color:var(--gold); margin-bottom:8px; }
  .tips ul { padding-left:18px; font-size:14px; line-height:1.7; color:var(--white); }
  footer { text-align:center; margin-top:40px; font-size:12px; color:var(--muted); }
</style>
</head>
<body>
<div class="wrap">
  <header>
    <div class="eyebrow">Corinda State High School</div>
    <h1>Home Group Helpers</h1>
    <p class="lede">Thanks for helping run Home Group. Choose what you are helping with. It opens in this tab.</p>
  </header>

  <div class="grid">
    <a class="card" href="games/index.aspx">
      <span class="emoji">🎮</span>
      <div class="title">Games</div>
      <div class="desc">Wordle, Connections, Weekly Trivia and more. Choose your house and group when a game loads.</div>
    </a>
    <a class="card" href="homegroup-lessons/homegroup-lessons.aspx">
      <span class="emoji">📘</span>
      <div class="title">Activities</div>
      <div class="desc">The Home Group activity cards. Open the card marked THIS WEEK and follow the numbered steps.</div>
    </a>
  </div>

  <div class="tips">
    <h2>Before you start</h2>
    <ul>
      <li>Ask your teacher before you start a game or an activity.</li>
      <li>Choose your own house and group, and play each game once.</li>
      <li>Stay in this tab. If a page asks for the password again, type it in again.</li>
    </ul>
  </div>

  <footer>Corinda SHS · Positive Education</footer>
</div>
</body>
</html>
