<%@ Page ContentType="text/html" ResponseEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Character Strengths Survey — Corinda SHS</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@400;500;600;700&display=swap');

  :root {
    --green:  #1a4731;
    --green2: #235c3f;
    --gold:   #c9a227;
    --gold-lt:#f0d97a;
    --cream:  #faf7f0;
    --ink:    #1a1a1a;
    --muted:  #6b7280;
    --border: #e2ddd4;
    --white:  #ffffff;
  }

  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
  body { font-family: 'Inter', sans-serif; background: var(--cream); color: var(--ink); min-height: 100vh; }

  /* ── HEADER ── */
  header { background: var(--green); padding: 1.5rem 2rem; display: flex; align-items: center; gap: 1rem; }
  .logo-ring { width: 44px; height: 44px; border: 2px solid var(--gold); border-radius: 50%; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
  .logo-ring svg { width: 24px; height: 24px; fill: var(--gold); }
  header h1 { font-family: 'DM Serif Display', serif; color: var(--white); font-size: 1.2rem; line-height: 1.2; }
  header h1 span { display: block; font-family: 'Inter', sans-serif; font-size: 0.7rem; font-weight: 500; color: var(--gold-lt); letter-spacing: 0.08em; text-transform: uppercase; margin-bottom: 0.15rem; }

  main { max-width: 760px; margin: 0 auto; padding: 2rem 1.5rem 4rem; }

  /* ── INTRO ── */
  .intro { background: var(--white); border: 1px solid var(--border); border-top: 4px solid var(--gold); border-radius: 8px; padding: 1.75rem 2rem; margin-bottom: 2rem; }
  .intro h2 { font-family: 'DM Serif Display', serif; font-size: 1.6rem; color: var(--green); margin-bottom: 0.5rem; }
  .intro p { color: var(--muted); font-size: 0.92rem; line-height: 1.6; }
  .intro p + p { margin-top: 0.5rem; }

  /* ── PROGRESS ── */
  .progress-wrap { margin-bottom: 2rem; }
  .progress-label { display: flex; justify-content: space-between; font-size: 0.8rem; color: var(--muted); margin-bottom: 0.4rem; }
  .progress-bar { height: 6px; background: var(--border); border-radius: 3px; overflow: hidden; }
  .progress-fill { height: 100%; background: var(--gold); border-radius: 3px; transition: width 0.4s ease; }

  /* ── STAGE BADGE ── */
  .stage-badge { display: inline-block; background: var(--green); color: var(--gold-lt); font-size: 0.68rem; font-weight: 700; letter-spacing: 0.1em; text-transform: uppercase; padding: 0.25rem 0.7rem; border-radius: 99px; margin-bottom: 0.75rem; }

  /* ── QUESTION CARDS (Stage 1) ── */
  .q-number { font-size: 0.7rem; font-weight: 600; color: var(--muted); letter-spacing: 0.08em; text-transform: uppercase; margin-bottom: 0.5rem; }
  .strength-card { background: var(--white); border: 1px solid var(--border); border-radius: 8px; padding: 1.25rem 1.5rem; margin-bottom: 0.75rem; transition: border-color 0.2s, box-shadow 0.2s; }
  .strength-card.rated { border-color: #c9a22760; box-shadow: 0 1px 6px rgba(201,162,39,0.12); }
  .strength-desc { font-size: 0.93rem; line-height: 1.6; margin-bottom: 1rem; color: var(--ink); }
  .rating-labels { display: flex; justify-content: space-between; font-size: 0.7rem; color: var(--muted); margin-bottom: 0.35rem; }
  .rating-options { display: flex; gap: 0.4rem; }
  .rating-btn { width: 42px; height: 42px; border-radius: 6px; border: 2px solid var(--border); background: var(--cream); font-size: 0.85rem; font-weight: 600; color: var(--muted); cursor: pointer; transition: all 0.15s; display: flex; align-items: center; justify-content: center; }
  .rating-btn:hover { border-color: var(--gold); color: var(--ink); }
  .rating-btn:focus-visible { outline: 2px solid var(--gold); outline-offset: 2px; }
  .rating-btn.selected { background: var(--green); border-color: var(--green); color: var(--white); }
  .rating-btn[data-val="5"].selected { background: var(--gold); border-color: var(--gold); color: var(--ink); }

  /* ── ROLE SELECT ── */
  .role-options { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-top: 0.5rem; }
  .role-btn { border: 2px solid var(--border); border-radius: 10px; background: var(--white); padding: 1.5rem 1.25rem; cursor: pointer; text-align: center; transition: all 0.15s; font-family: 'Inter', sans-serif; }
  .role-btn:hover { border-color: var(--gold); transform: translateY(-2px); box-shadow: 0 4px 12px rgba(201,162,39,0.15); }
  .role-btn:focus-visible { outline: 2px solid var(--gold); outline-offset: 2px; }
  .role-btn:active { transform: translateY(0); }
  .role-btn-title { font-family: 'DM Serif Display', serif; font-size: 1.3rem; color: var(--green); margin-bottom: 0.4rem; }
  .role-btn-desc { font-size: 0.85rem; color: var(--muted); line-height: 1.5; }
  @media (max-width: 520px) { .role-options { grid-template-columns: 1fr; } }

  /* ── STAGE 1 (hidden until a role is chosen) ── */
  #survey { display: none; }

  /* ── STAGE 2: FORCED CHOICE ── */
  #stage2 { display: none; }
  .fc-intro { background: var(--white); border: 1px solid var(--border); border-top: 4px solid var(--gold); border-radius: 8px; padding: 1.5rem 1.75rem; margin-bottom: 1.5rem; }
  .fc-intro h2 { font-family: 'DM Serif Display', serif; font-size: 1.4rem; color: var(--green); margin-bottom: 0.4rem; }
  .fc-intro p { color: var(--muted); font-size: 0.9rem; line-height: 1.6; }
  .fc-card { background: var(--white); border: 1px solid var(--border); border-radius: 10px; padding: 1.75rem; }
  .fc-question { font-size: 0.78rem; font-weight: 600; color: var(--muted); letter-spacing: 0.06em; text-transform: uppercase; text-align: center; margin-bottom: 1.25rem; }
  .fc-options { display: grid; grid-template-columns: 1fr auto 1fr; gap: 0.75rem; align-items: stretch; }
  .fc-vs { display: flex; align-items: center; justify-content: center; font-family: 'DM Serif Display', serif; font-size: 1.1rem; color: var(--gold); }
  .fc-option { border: 2px solid var(--border); border-radius: 10px; background: var(--cream); padding: 1.25rem 1rem; cursor: pointer; text-align: left; transition: all 0.15s; font-family: 'Inter', sans-serif; }
  .fc-option:hover { border-color: var(--gold); background: var(--white); transform: translateY(-2px); box-shadow: 0 4px 12px rgba(201,162,39,0.15); }
  .fc-option:focus-visible { outline: 2px solid var(--gold); outline-offset: 2px; }
  .fc-option:active { transform: translateY(0); }
  .fc-opt-name { font-family: 'DM Serif Display', serif; font-size: 1.15rem; color: var(--green); margin-bottom: 0.4rem; }
  .fc-opt-text { font-size: 0.85rem; line-height: 1.55; color: var(--ink); }
  .quad-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 0.7rem; }
  .quad-card { border: 2px solid var(--border); border-radius: 10px; background: var(--cream); padding: 1.1rem 1rem; cursor: pointer; text-align: left; transition: all 0.15s; font-family: 'Inter', sans-serif; position: relative; }
  .quad-card:hover { border-color: var(--gold); background: var(--white); }
  .quad-card:focus-visible { outline: 2px solid var(--gold); outline-offset: 2px; }
  .quad-card.is-most { border-color: var(--gold); background: var(--white); box-shadow: 0 0 0 2px var(--gold) inset; cursor: default; }
  .quad-card.is-least { border-color: var(--muted); opacity: 0.55; cursor: default; }
  .quad-tag { position: absolute; top: -10px; right: 10px; font-size: 0.62rem; font-weight: 700; letter-spacing: 0.08em; text-transform: uppercase; padding: 2px 8px; border-radius: 99px; }
  .quad-card.is-most .quad-tag { background: var(--gold); color: var(--ink); }
  .quad-card.is-least .quad-tag { background: var(--muted); color: var(--white); }
  .quad-text { font-size: 0.86rem; line-height: 1.55; color: var(--ink); }
  .quad-redo { background: none; border: none; font-family: 'Inter', sans-serif; font-size: 0.78rem; color: var(--muted); cursor: pointer; text-decoration: underline; }
  .quad-redo:hover { color: var(--ink); }
  @media (max-width: 520px) { .quad-grid { grid-template-columns: 1fr; } }
  @media (prefers-reduced-motion: reduce) {
    .fc-option:hover { transform: none; }
    * { transition-duration: 0.01ms !important; }
  }

  /* ── SUBMIT ── */
  .submit-wrap { margin-top: 2.5rem; text-align: center; }
  .submit-btn { background: var(--green); color: var(--white); border: none; border-radius: 8px; padding: 0.9rem 2.5rem; font-size: 1rem; font-weight: 600; cursor: pointer; transition: background 0.2s, transform 0.1s; }
  .submit-btn:hover { background: var(--green2); }
  .submit-btn:active { transform: scale(0.98); }
  .submit-btn:disabled { opacity: 0.45; cursor: not-allowed; }
  .submit-note { font-size: 0.78rem; color: var(--muted); margin-top: 0.6rem; }

  /* ── RESULTS ── */
  #results { display: none; }
  .results-header { background: var(--green); color: var(--white); border-radius: 10px; padding: 2rem; margin-bottom: 2rem; text-align: center; }
  .results-header h2 { font-family: 'DM Serif Display', serif; font-size: 1.8rem; margin-bottom: 0.3rem; }
  .results-header p { font-size: 0.88rem; opacity: 0.8; }

  .sig-card { background: var(--white); border: 1px solid var(--border); border-left: 5px solid var(--gold); border-radius: 10px; padding: 1.4rem 1.6rem; margin-bottom: 0.75rem; }
  .sig-rank { font-size: 0.7rem; font-weight: 700; color: var(--gold); letter-spacing: 0.1em; text-transform: uppercase; margin-bottom: 0.3rem; }
  .sig-name { font-family: 'DM Serif Display', serif; font-size: 1.35rem; color: var(--green); }
  .sig-virtue { display: inline-block; font-size: 0.7rem; font-weight: 700; letter-spacing: 0.06em; text-transform: uppercase; margin: 0.3rem 0 0.6rem; }
  .sig-desc { font-size: 0.9rem; line-height: 1.6; color: var(--ink); }
  .sig-link { display: inline-block; margin-top: 0.7rem; font-size: 0.82rem; font-weight: 600; color: var(--green); text-decoration: none; border-bottom: 1.5px solid var(--gold); padding-bottom: 1px; }
  .sig-link:hover { color: var(--green2); }

  .other-title { font-family: 'DM Serif Display', serif; font-size: 1.25rem; color: var(--green); margin: 2.25rem 0 0.35rem; }
  .other-note { font-size: 0.82rem; color: var(--muted); line-height: 1.55; margin-bottom: 1.25rem; }
  .virtue-group { background: var(--white); border: 1px solid var(--border); border-radius: 8px; padding: 1rem 1.25rem; margin-bottom: 0.6rem; }
  .virtue-group-name { font-size: 0.72rem; font-weight: 700; letter-spacing: 0.08em; text-transform: uppercase; margin-bottom: 0.6rem; }
  .virtue-chips { display: flex; flex-wrap: wrap; gap: 0.45rem; }
  .virtue-chip { font-size: 0.82rem; font-weight: 500; border: 1px solid var(--border); border-radius: 99px; padding: 0.3rem 0.8rem; background: var(--cream); }

  /* ── ACTIONS ── */
  .results-actions { margin-top: 2rem; text-align: center; display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap; }
  .btn-outline { background: transparent; border: 2px solid var(--green); color: var(--green); border-radius: 8px; padding: 0.7rem 1.5rem; font-size: 0.9rem; font-weight: 600; cursor: pointer; transition: all 0.2s; }
  .btn-outline:hover { background: var(--green); color: var(--white); }
  .btn-primary-outline { background: var(--green); color: var(--white); border: 2px solid var(--green); border-radius: 8px; padding: 0.7rem 1.5rem; font-size: 0.9rem; font-weight: 600; cursor: pointer; transition: all 0.2s; }
  .btn-primary-outline:hover { background: var(--green2); border-color: var(--green2); }

  /* ── PDF MODAL ── */
  .modal-overlay { display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.5); z-index: 100; align-items: center; justify-content: center; }
  .modal-overlay.open { display: flex; }
  .modal { background: var(--white); border-radius: 10px; padding: 2rem; max-width: 400px; width: 90%; box-shadow: 0 20px 60px rgba(0,0,0,0.2); }
  .modal h3 { font-family: 'DM Serif Display', serif; font-size: 1.3rem; color: var(--green); margin-bottom: 0.4rem; }
  .modal p { font-size: 0.85rem; color: var(--muted); margin-bottom: 1.25rem; line-height: 1.5; }
  .modal label { display: block; font-size: 0.82rem; font-weight: 600; margin-bottom: 0.35rem; }
  .modal input { width: 100%; border: 1.5px solid var(--border); border-radius: 6px; padding: 0.6rem 0.8rem; font-size: 0.9rem; font-family: 'Inter', sans-serif; outline: none; transition: border-color 0.2s; }
  .modal input:focus { border-color: var(--gold); }
  .modal-actions { display: flex; gap: 0.75rem; margin-top: 1.25rem; }
  .modal-actions .btn-primary { flex: 1; background: var(--green); color: var(--white); border: none; border-radius: 7px; padding: 0.7rem; font-size: 0.9rem; font-weight: 600; cursor: pointer; }
  .modal-actions .btn-primary:hover { background: var(--green2); }
  .modal-actions .btn-cancel { background: transparent; border: 1.5px solid var(--border); border-radius: 7px; padding: 0.7rem 1rem; font-size: 0.9rem; color: var(--muted); cursor: pointer; }
  .modal-actions .btn-cancel:hover { border-color: var(--muted); }

  @media (max-width: 520px) {
    main { padding: 1.25rem 1rem 3rem; }
    .rating-btn { width: 38px; height: 38px; font-size: 0.8rem; }
    .fc-options { grid-template-columns: 1fr; }
    .fc-vs { padding: 0.1rem 0; }
  }

  /* ════════════════════════════════════════
     PRINT / PDF REPORT STYLES
  ════════════════════════════════════════ */
  #pdf-report { display: none; }

  @media print {
    @page { size: A4; margin: 0; }
    body > * { display: none !important; }
    #pdf-report { display: block !important; }

    .pdf-page { width: 210mm; height: 297mm; max-height: 297mm; overflow: hidden; page-break-after: avoid; padding: 0; background: white; font-family: 'Inter', sans-serif; color: #1a1a1a; -webkit-print-color-adjust: exact; print-color-adjust: exact; }
    .pdf-cover { background: #1a4731; padding: 12mm 20mm 9mm; color: white; -webkit-print-color-adjust: exact; print-color-adjust: exact; }
    .pdf-cover-eyebrow { font-size: 8pt; font-weight: 600; letter-spacing: 0.12em; text-transform: uppercase; color: #f0d97a; margin-bottom: 3mm; }
    .pdf-cover h1 { font-family: 'DM Serif Display', serif; font-size: 20pt; line-height: 1.15; margin-bottom: 3mm; }
    .pdf-cover-meta { font-size: 9pt; opacity: 0.75; display: flex; gap: 8mm; }
    .pdf-rule { height: 2mm; background: #c9a227; -webkit-print-color-adjust: exact; print-color-adjust: exact; }
    .pdf-body { padding: 6mm 16mm 8mm; }
    .pdf-section-title { font-size: 8pt; font-weight: 700; letter-spacing: 0.1em; text-transform: uppercase; color: #1a4731; border-bottom: 1px solid #e2ddd4; padding-bottom: 1.5mm; margin-bottom: 3mm; margin-top: 4mm; }
    .pdf-section-title:first-child { margin-top: 0; }
    .pdf-sig-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 3mm; margin-bottom: 1mm; }
    .pdf-sig-card { border: 1px solid #e2ddd4; border-radius: 2.5mm; padding: 3mm 4mm; page-break-inside: avoid; }
    .pdf-sig-rank { font-size: 7pt; font-weight: 700; color: #c9a227; margin-bottom: 1mm; }
    .pdf-sig-name { font-size: 11pt; font-weight: 700; color: #1a4731; margin-bottom: 1mm; }
    .pdf-sig-virtue { font-size: 7pt; font-weight: 600; letter-spacing: 0.06em; text-transform: uppercase; margin-bottom: 2mm; }
    .pdf-sig-desc { font-size: 7.5pt; line-height: 1.45; color: #374151; }
    .pdf-sig-card.full-width { grid-column: 1 / -1; }
    .pdf-virtue-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 2mm 6mm; }
    .pdf-virtue-group { margin-bottom: 2mm; page-break-inside: avoid; }
    .pdf-virtue-name { font-size: 7.5pt; font-weight: 700; letter-spacing: 0.06em; text-transform: uppercase; margin-bottom: 1.5mm; }
    .pdf-virtue-list { font-size: 8pt; line-height: 1.45; color: #374151; }
    .pdf-note { font-size: 7pt; color: #6b7280; line-height: 1.4; margin-top: 2mm; font-style: italic; }
    .pdf-footer { margin-top: 4mm; padding-top: 3mm; border-top: 1px solid #e2ddd4; font-size: 7pt; color: #9ca3af; display: flex; justify-content: space-between; }
  }
</style>
</head>
<body>

<!-- ══ HEADER ══════════════════════════════════════════════════════════════ -->
<header>
  <div class="logo-ring">
    <svg viewBox="0 0 24 24"><path d="M12 2l2.4 7.4H22l-6.2 4.5 2.4 7.4L12 17 5.8 21.3l2.4-7.4L2 9.4h7.6z"/></svg>
  </div>
  <h1><span>Corinda State High School</span>Character Strengths Survey</h1>
</header>

<main>
  <!-- ══ STAGE 0: ROLE SELECT ═══════════════════════════════════════════════ -->
  <div id="role-select">
    <div class="intro">
      <span class="stage-badge">Before you begin</span>
      <h2>Who's completing this survey?</h2>
      <p>The wording of a few questions is simplified for students, but the strengths, scoring and results are exactly the same either way.</p>
    </div>
    <div class="role-options">
      <button class="role-btn" id="role-staff" type="button">
        <div class="role-btn-title">Staff</div>
        <div class="role-btn-desc">Standard wording.</div>
      </button>
      <button class="role-btn" id="role-student" type="button">
        <div class="role-btn-title">Student</div>
        <div class="role-btn-desc">Simpler, student-friendly wording.</div>
      </button>
    </div>
  </div>

  <!-- ══ STAGE 1: RATINGS ═══════════════════════════════════════════════════ -->
  <div id="survey">
    <div class="intro">
      <span class="stage-badge">Round 1 of 2</span>
      <h2>Character Strengths Survey</h2>
      <p>Rate how accurately each statement describes you, from 1 (not like me at all) to 5 (very much like me). There are no right or wrong answers — candid responses give the most useful results.</p>
      <p>This survey uses a two-stage adaptive format: 24 ratings, followed by a short head-to-head round between your highest-rated strengths to determine your top 5.</p>
      <p id="privacy-note">Nothing is recorded while you complete the survey. At the end, you can submit your top 5 to the Positive Education team if you'd like to.</p>
    </div>
    <div class="progress-wrap">
      <div class="progress-label"><span>Round 1 — Ratings</span><span id="prog-text">0 of 24 answered</span></div>
      <div class="progress-bar"><div class="progress-fill" id="prog-fill" style="width:0%"></div></div>
    </div>
    <div id="strengths-form"></div>
    <div class="submit-wrap">
      <button class="submit-btn" id="submit-btn" disabled>Continue to round 2</button>
      <p class="submit-note" id="submit-note">Answer all 24 questions to continue</p>
    </div>
  </div>

  <!-- ══ STAGE 2: HEAD-TO-HEAD ═══════════════════════════════════════════════ -->
  <div id="stage2">
    <div class="fc-intro">
      <span class="stage-badge">Round 2 of 2 — Head-to-head</span>
      <h2>Your strongest strengths, head-to-head</h2>
      <p>Your highest-rated strengths are too close to separate on ratings alone. For each pair, select the one that describes you <strong>more accurately</strong>. First instincts are usually the most reliable.</p>
    </div>
    <div class="progress-wrap">
      <div class="progress-label"><span>Round 2 — Head-to-head</span><span id="fc-prog-text"></span></div>
      <div class="progress-bar"><div class="progress-fill" id="fc-prog-fill" style="width:0%"></div></div>
    </div>
    <div class="fc-card">
      <div class="fc-question" id="fc-question">Which describes you more accurately?</div>
      <div class="fc-options" id="fc-options"></div>
    </div>
  </div>

  <!-- ══ RESULTS ══════════════════════════════════════════════════════════════ -->
  <div id="results">
    <div class="results-header">
      <h2>Your Signature Strengths</h2>
      <p>The five strengths that ranked highest across both rounds — the ones most characteristic of you.</p>
    </div>
    <div id="sig-cards"></div>

    <h3 class="other-title">Your other strengths</h3>
    <p class="other-note">Everyone possesses all 24 strengths — those outside your top 5 are lesser strengths, not weaknesses. They're grouped by virtue rather than ranked, as differences beyond the top 5 are small and a strict ordering would imply more precision than the survey can support.</p>
    <div id="virtue-groups"></div>

    <div class="results-actions">
      <button class="btn-outline" id="retake-btn">Retake survey</button>
      <button class="btn-outline" id="pdf-btn">⬇ Download PDF report</button>
      <button class="btn-primary-outline" id="share-btn">Submit</button>
    </div>
  </div>

  <p style="margin-top:3rem; font-size:0.72rem; color:var(--muted); line-height:1.6; text-align:center;">This survey was developed by Corinda State High School for educational and reflective purposes. It is inspired by the VIA Classification of Character Strengths (Peterson &amp; Seligman) but is not an official VIA Institute assessment. The official VIA survey is available free at <a href="https://www.viacharacter.org" target="_blank" rel="noopener" style="color:var(--green);">viacharacter.org</a>.</p>
</main>

<!-- ══ PDF NAME MODAL ══════════════════════════════════════════════════════════ -->
<div class="modal-overlay" id="pdf-modal">
  <div class="modal">
    <h3>Download PDF report</h3>
    <p>Your browser will open a print dialog. Choose "Save as PDF" to save the report. You can then attach it to an email.</p>
    <label for="pdf-name-input">Your name (optional)</label>
    <input type="text" id="pdf-name-input" placeholder="e.g. Alex Smith" maxlength="60" autocomplete="off">
    <div class="modal-actions">
      <button class="btn-cancel" id="modal-cancel">Cancel</button>
      <button class="btn-primary" id="modal-confirm">Generate PDF</button>
    </div>
  </div>
</div>

<!-- ══ SHARE MODAL ════════════════════════════════════════════════════════════ -->
<div class="modal-overlay" id="share-modal">
  <div class="modal">
    <h3>Submit your results</h3>
    <p>This submits your full name, house, homegroup, top 5 strengths, top strength, and VIA comparison response to the Positive Education team through the school Microsoft Form. A pre-filled form will open; check the details and press Submit.</p>
    <label for="share-name-input">Your full name</label>
    <input type="text" id="share-name-input" placeholder="e.g. Alex Smith" maxlength="60" autocomplete="off">
    <p style="font-size:0.78rem;color:var(--muted);margin-top:0.3rem;">Please use your real first and last name so results can be matched correctly.</p>
    <label for="share-house-select" style="margin-top:0.9rem;">Your house</label>
    <select id="share-house-select" style="width:100%;border:1.5px solid var(--border);border-radius:6px;padding:0.6rem 0.8rem;font-size:0.9rem;font-family:'Inter',sans-serif;background:var(--white);">
      <option value="">Choose your house…</option>
      <option>Bunar</option>
      <option>Dibbil</option>
      <option>Kabul</option>
      <option>Moori</option>
      <option>Pirri</option>
      <option>Yarraman</option>
    </select>
    <div id="share-homegroup-wrap" style="margin-top:0.9rem;">
      <label for="share-homegroup-select">Your homegroup letter</label>
      <select id="share-homegroup-select" style="width:100%;border:1.5px solid var(--border);border-radius:6px;padding:0.6rem 0.8rem;font-size:0.9rem;font-family:'Inter',sans-serif;background:var(--white);">
        <option value="">Choose your homegroup letter…</option>
        <option>A</option><option>B</option><option>C</option><option>D</option>
        <option>E</option><option>F</option><option>G</option><option>H</option>
        <option>I</option><option>J</option><option>K</option><option>L</option>
        <option>M</option><option>N</option>
      </select>
    </div>
    <label for="share-via-select" style="margin-top:0.9rem;">How many of your top 5 here matched your official VIA survey results?</label>
    <select id="share-via-select" style="width:100%;border:1.5px solid var(--border);border-radius:6px;padding:0.6rem 0.8rem;font-size:0.9rem;font-family:'Inter',sans-serif;background:var(--white);">
      <option value="">Select…</option>
      <option value="5 of 5">5 of 5</option>
      <option value="4 of 5">4 of 5</option>
      <option value="3 of 5">3 of 5</option>
      <option value="2 of 5">2 of 5</option>
      <option value="1 of 5">1 of 5</option>
      <option value="0 of 5">0 of 5</option>
      <option value="Haven't done the VIA survey">I haven't done the VIA survey</option>
      <option value="Can't remember my VIA results">I can't remember my VIA results</option>
    </select>
    <div class="modal-actions">
      <button class="btn-cancel" id="share-cancel">Cancel</button>
      <button class="btn-primary" id="share-confirm">Open form</button>
    </div>
  </div>
</div>

<!-- ══ HIDDEN PDF REPORT ══════════════════════════════════════════════════════ -->
<div id="pdf-report">
  <div class="pdf-page">
    <div class="pdf-cover">
      <div class="pdf-cover-eyebrow">Corinda State High School &nbsp;·&nbsp; Positive Education</div>
      <h1>Character<br>Strengths Report</h1>
      <div class="pdf-cover-meta">
        <span id="pdf-meta-name"></span>
        <span id="pdf-meta-date"></span>
      </div>
    </div>
    <div class="pdf-rule"></div>
    <div class="pdf-body">
      <div class="pdf-section-title">Your top 5 signature strengths</div>
      <div class="pdf-sig-grid" id="pdf-sig-grid"></div>

      <div class="pdf-section-title">Your other strengths, by virtue</div>
      <div id="pdf-virtue-groups" class="pdf-virtue-grid"></div>
      <div class="pdf-note">Everyone has all 24 strengths. Those outside your top 5 are lesser strengths, not weaknesses — strengths you draw on less often. They are grouped by virtue rather than ranked.</div>

      <div class="pdf-footer">
        <span>Developed by Corinda SHS · Inspired by the VIA Classification · Not an official VIA Institute assessment</span>
        <span>viacharacter.org</span>
      </div>
    </div>
  </div>
</div>

<!-- ══ SCRIPT ══════════════════════════════════════════════════════════════════ -->
<script>
/*
  Two-stage adaptive design:
  Round 1 — one Likert item per strength (24 items, the more behavioural item of each original pair).
  Round 2 — the top contenders (top 8 by rating, plus any ties at the cut) face off in two
  rounds of head-to-head forced-choice pairs (~8 picks). Wins refine the order at the top,
  which is where accuracy matters. The forced-choice statement is the second item from the
  original pair, so each strength is still measured by two distinct items overall.
  Final score = round 1 rating + 0.6 × head-to-head wins (contenders only).
*/
// Shared across both roles — identity, virtue grouping and colour never change.
const STRENGTH_META = [
  { id: 'creativity',   name: 'Creativity',              virtue: 'Wisdom',        virtueColor: '#2e6b9e' },
  { id: 'curiosity',    name: 'Curiosity',                virtue: 'Wisdom',        virtueColor: '#2e6b9e' },
  { id: 'judgement',    name: 'Judgement',                virtue: 'Wisdom',        virtueColor: '#2e6b9e' },
  { id: 'learning',     name: 'Love of Learning',          virtue: 'Wisdom',        virtueColor: '#2e6b9e' },
  { id: 'perspective',  name: 'Perspective',              virtue: 'Wisdom',        virtueColor: '#2e6b9e' },
  { id: 'bravery',      name: 'Bravery',                  virtue: 'Courage',       virtueColor: '#b94030' },
  { id: 'perseverance', name: 'Perseverance',             virtue: 'Courage',       virtueColor: '#b94030' },
  { id: 'honesty',      name: 'Honesty',                  virtue: 'Courage',       virtueColor: '#b94030' },
  { id: 'zest',         name: 'Zest',                     virtue: 'Courage',       virtueColor: '#b94030' },
  { id: 'love',         name: 'Love',                     virtue: 'Humanity',      virtueColor: '#c75e8b' },
  { id: 'kindness',     name: 'Kindness',                 virtue: 'Humanity',      virtueColor: '#c75e8b' },
  { id: 'social',       name: 'Social Intelligence',       virtue: 'Humanity',      virtueColor: '#c75e8b' },
  { id: 'teamwork',     name: 'Teamwork',                 virtue: 'Justice',       virtueColor: '#3a7d44' },
  { id: 'fairness',     name: 'Fairness',                 virtue: 'Justice',       virtueColor: '#3a7d44' },
  { id: 'leadership',   name: 'Leadership',               virtue: 'Justice',       virtueColor: '#3a7d44' },
  { id: 'forgiveness',  name: 'Forgiveness',              virtue: 'Temperance',    virtueColor: '#7b5ea7' },
  { id: 'humility',     name: 'Humility',                 virtue: 'Temperance',    virtueColor: '#7b5ea7' },
  { id: 'prudence',     name: 'Prudence',                 virtue: 'Temperance',    virtueColor: '#7b5ea7' },
  { id: 'regulation',   name: 'Self-Regulation',           virtue: 'Temperance',    virtueColor: '#7b5ea7' },
  { id: 'appreciation', name: 'Appreciation of Beauty',    virtue: 'Transcendence', virtueColor: '#c07820' },
  { id: 'gratitude',    name: 'Gratitude',                virtue: 'Transcendence', virtueColor: '#c07820' },
  { id: 'hope',         name: 'Hope',                     virtue: 'Transcendence', virtueColor: '#c07820' },
  { id: 'humour',       name: 'Humour',                   virtue: 'Transcendence', virtueColor: '#c07820' },
  { id: 'spirituality', name: 'Spirituality',             virtue: 'Transcendence', virtueColor: '#c07820' }
];

// Per-role wording. Same strengths, same order, same scoring — only the
// phrasing of desc/rate/fc changes between the two.
const CONTENT = {
  staff: {
    creativity:   { desc: 'Coming up with ideas is your natural mode. When something isn\'t working, your instinct is to invent a different route rather than push harder down the existing one.',
                    rate: 'I often find new or unexpected ways to approach everyday problems.',
                    fc: 'I enjoy coming up with original ideas, even when a simpler solution already exists.' },
    curiosity:    { desc: 'Unanswered questions bother you in the best way. New topics, places, and ideas pull you in, and you\'d rather investigate something than leave it unexplained.',
                    rate: 'I regularly ask questions or look things up simply because I want to know more.',
                    fc: 'I find almost every topic interesting and like to explore things just to see where they lead.' },
    judgement:    { desc: 'You weigh things up before you commit to a view. Evidence matters more to you than first impressions, and being shown you were wrong feels useful rather than threatening.',
                    rate: 'I am willing to change my opinion when the evidence points in a different direction.',
                    fc: 'I try to look at a situation from multiple angles before making up my mind.' },
    learning:     { desc: 'Adding to what you know is genuinely satisfying for you, whether or not anyone is grading it. You build skills and knowledge for their own sake.',
                    rate: 'I seek out opportunities to expand my knowledge, even outside of school or work.',
                    fc: 'I get genuinely excited when I have the chance to learn something new.' },
    perspective:  { desc: 'You tend to see how the pieces of a situation fit together, which is why people seek your take when things get complicated. Your advice tends to be measured and worth having.',
                    rate: 'People often come to me when they need a thoughtful or balanced point of view.',
                    fc: 'I find it easy to step back from a problem and see the bigger picture.' },
    bravery:      { desc: 'Discomfort doesn\'t decide your actions. Whether it\'s a hard conversation, an unpopular stance, or a risky attempt, you\'d rather act on your convictions than stay safely quiet.',
                    rate: 'I speak up for what I believe is right, even when others disagree.',
                    fc: 'I do not back down from difficult situations just because they make me uncomfortable.' },
    perseverance: { desc: 'Once you\'ve started something, abandoning it doesn\'t sit right with you. Obstacles tend to sharpen your focus rather than drain it, and you take real satisfaction in seeing things through.',
                    rate: 'I finish what I start, even when the task becomes difficult or tedious.',
                    fc: 'Setbacks motivate me to keep going rather than give up.' },
    honesty:      { desc: 'What people see from you is what\'s actually there. You\'d rather deliver an uncomfortable truth than maintain a comfortable pretence, and you hold yourself to the same standard.',
                    rate: 'I say what I mean and mean what I say, even when the truth is hard to hear.',
                    fc: 'I present myself as I really am rather than trying to impress people.' },
    zest:         { desc: 'You bring energy with you. Days feel like something to be used rather than gotten through, and your enthusiasm tends to be contagious in the rooms you\'re in.',
                    rate: 'I throw myself into things with energy and enthusiasm.',
                    fc: 'I rarely do anything half-heartedly — I prefer to give my full effort.' },
    love:         { desc: 'The people closest to you are central to how you live, not an accessory to it. You invest in those relationships openly, and you let people matter to you.',
                    rate: 'I find it easy to show warmth and care to the people I am close to.',
                    fc: 'Close relationships are one of the most important things in my life.' },
    kindness:     { desc: 'Helping is your default setting. You notice what others need, often before they ask, and doing something about it costs you less effort than ignoring it would.',
                    rate: 'I often go out of my way to help someone, even if I do not know them well.',
                    fc: 'I enjoy doing things for others, even when there is nothing in it for me.' },
    social:       { desc: 'You read rooms well. Shifts in mood, unspoken tension, what someone actually means — you pick these up quickly and adjust how you engage accordingly.',
                    rate: 'I can usually tell how someone is feeling, even when they do not say it outright.',
                    fc: 'I adjust how I act depending on the people I am with and the situation I am in.' },
    teamwork:     { desc: 'When you\'re part of a group, the group\'s result becomes your result. You carry your share reliably and people learn quickly that you can be counted on.',
                    rate: 'I am a reliable team member who pulls their weight and supports others.',
                    fc: 'I feel a strong sense of loyalty to the groups and teams I am part of.' },
    fairness:     { desc: 'Even-handedness matters to you on principle. You apply the same standards to people you like and people you don\'t, and double standards genuinely grate on you.',
                    rate: 'I try to treat everyone equally, regardless of how I personally feel about them.',
                    fc: 'It bothers me when people are treated differently based on favouritism rather than merit.' },
    leadership:   { desc: 'When a group needs direction, you\'re willing to provide it. You\'re good at turning a loose collection of people into something organised — and at making sure nobody gets left on the outside while it happens.',
                    rate: 'I am comfortable taking charge and organising people to get things done.',
                    fc: 'I try to make sure everyone in a group feels included and motivated.' },
    forgiveness:  { desc: 'You give people a way back. Holding onto resentment strikes you as a poor trade, and you\'d rather understand why something happened than keep score over it.',
                    rate: 'I can let go of grudges and move on after someone has done something wrong.',
                    fc: 'I try to understand why people make mistakes rather than just holding it against them.' },
    humility:     { desc: 'You don\'t need to be the headline. Your work can speak for itself, you take feedback without bristling, and you\'re comfortable acknowledging the limits of what you know.',
                    rate: 'I am genuinely open to feedback and recognise that I do not have all the answers.',
                    fc: 'I prefer to let my actions speak for themselves rather than seeking attention.' },
    prudence:     { desc: 'You look before you leap, habitually. Choices get weighed against where they lead, not just how they feel right now, which means you rarely get caught out by foreseeable problems.',
                    rate: 'I think carefully before acting and try to avoid unnecessary risks.',
                    fc: 'I consider the long-term consequences of my decisions, not just the immediate ones.' },
    regulation:   { desc: 'You run yourself with discipline. Impulses, moods, and temptations get a vote but not a veto — under pressure you stay deliberate when others get reactive.',
                    rate: 'I am good at managing my emotions, especially in stressful situations.',
                    fc: 'I can resist temptations or impulses when I know I should stay on track.' },
    appreciation: { desc: 'Quality stops you in your tracks — a striking sky, a piece of music, someone doing difficult work superbly. You notice excellence that others walk straight past, and it moves you.',
                    rate: 'I regularly notice and am moved by beauty in the world around me — in nature, art, or everyday life.',
                    fc: 'I feel a deep sense of wonder or awe fairly often.' },
    gratitude:    { desc: 'You keep track of the good in your life rather than taking it as given. You notice what others do for you, and you make sure they know it.',
                    rate: 'I make a point of expressing appreciation to people who have helped me.',
                    fc: 'I regularly feel thankful for the good things in my life.' },
    hope:         { desc: 'You treat the future as something to build, not something that happens to you. Setbacks read as temporary, and your optimism comes with effort attached.',
                    rate: 'I generally expect things to work out well, and I work toward making that happen.',
                    fc: 'Even in difficult times, I hold on to a sense that things will improve.' },
    humour:       { desc: 'You find the light side and you share it. Making people laugh is one of your main ways of connecting, and you can take the heaviness out of a room without taking the substance out of it.',
                    rate: 'I enjoy making people laugh and can find the funny side of most situations.',
                    fc: 'Laughter and playfulness are an important part of how I connect with others.' },
    spirituality: { desc: 'Your life is organised around a sense of meaning that goes beyond the day-to-day. That sense of purpose — and of belonging to something bigger — shapes the choices you make.',
                    rate: 'I have a strong sense of meaning or purpose that guides how I live my life.',
                    fc: 'I feel connected to something larger than myself, whether that is nature, community, or something else.' }
  },
  student: {
    creativity:   { desc: 'You like coming up with new ideas. If something isn\'t working, you\'d rather try a different way than keep doing the same thing.',
                    rate: 'I often think of new or different ways to do things.',
                    fc: 'I like coming up with my own ideas, even if there\'s already an easy way to do something.' },
    curiosity:    { desc: 'You love finding things out. New topics, places and ideas grab your attention, and you\'d rather look something up than leave it a mystery.',
                    rate: 'I ask questions or look things up just because I want to know more.',
                    fc: 'I find lots of different topics interesting and like exploring new things.' },
    judgement:    { desc: 'You like to think things through before deciding what you believe. Facts matter more to you than first impressions, and you don\'t mind being shown you were wrong.',
                    rate: 'I\'m willing to change my mind when I get new information.',
                    fc: 'I try to look at a situation from more than one side before deciding what I think.' },
    learning:     { desc: 'Learning new things feels good to you, whether or not it\'s for a mark. You like building your skills and knowledge just because you want to.',
                    rate: 'I look for chances to learn new things, even outside of class.',
                    fc: 'I get excited when I have the chance to learn something new.' },
    perspective:  { desc: 'You\'re good at seeing how all the parts of a situation fit together, which is why people ask for your advice when things get complicated.',
                    rate: 'People often come to me for advice because I can see the bigger picture.',
                    fc: 'I find it easy to step back from a problem and see the whole situation.' },
    bravery:      { desc: 'You don\'t let discomfort stop you. Whether it\'s a hard conversation, standing up for something, or trying something risky, you\'d rather act than stay quiet.',
                    rate: 'I speak up for what I think is right, even if others disagree.',
                    fc: 'I don\'t back away from hard situations just because they make me uncomfortable.' },
    perseverance: { desc: 'Once you\'ve started something, you don\'t like giving up on it. Obstacles make you more focused, not less, and finishing something feels great.',
                    rate: 'I finish what I start, even when it gets hard or boring.',
                    fc: 'Setbacks make me want to keep going rather than give up.' },
    honesty:      { desc: 'What people see from you is the real you. You\'d rather tell an uncomfortable truth than keep up a comfortable lie, and you expect the same from yourself.',
                    rate: 'I say what I mean, even when the truth is hard to say.',
                    fc: 'I show people who I really am instead of trying to impress them.' },
    zest:         { desc: 'You bring energy wherever you go. Days feel like something to make the most of, and your enthusiasm tends to rub off on the people around you.',
                    rate: 'I throw myself into things with energy and enthusiasm.',
                    fc: 'I rarely do things half-heartedly — I like to give full effort.' },
    love:         { desc: 'The people closest to you matter a lot to how you live your life. You put real effort into those relationships and let people matter to you.',
                    rate: 'I find it easy to show care and warmth to people I\'m close to.',
                    fc: 'Close relationships are one of the most important things in my life.' },
    kindness:     { desc: 'Helping people is just what you do. You notice what others need, often before they even ask, and helping feels easier than ignoring it.',
                    rate: 'I go out of my way to help someone, even if I don\'t know them well.',
                    fc: 'I like doing things for other people, even when I get nothing back.' },
    social:       { desc: 'You\'re good at reading people and situations. You notice moods, unspoken feelings, and what someone actually means — and you adjust how you act because of it.',
                    rate: 'I can usually tell how someone is feeling, even if they don\'t say it.',
                    fc: 'I change how I act depending on who I\'m with and the situation I\'m in.' },
    teamwork:     { desc: 'When you\'re part of a group, the group\'s success becomes your success. You do your share and people know they can count on you.',
                    rate: 'I\'m a reliable team member who does my part and supports others.',
                    fc: 'I feel loyal to the groups and teams I\'m part of.' },
    fairness:     { desc: 'Treating people equally matters to you. You hold everyone to the same standard, whether you like them or not, and unfairness really bothers you.',
                    rate: 'I try to treat everyone the same, no matter how I feel about them personally.',
                    fc: 'It bothers me when people are treated differently because of favouritism instead of what\'s fair.' },
    leadership:   { desc: 'When a group needs direction, you\'re willing to step up. You\'re good at organising people to get things done — and making sure nobody gets left out.',
                    rate: 'I\'m comfortable taking charge and organising people to get things done.',
                    fc: 'I try to make sure everyone in a group feels included.' },
    forgiveness:  { desc: 'You give people a second chance. Holding onto anger doesn\'t feel worth it to you, and you\'d rather understand why something happened than hold it against someone.',
                    rate: 'I can let go of grudges and move on after someone has done something wrong.',
                    fc: 'I try to understand why people make mistakes instead of holding it against them.' },
    humility:     { desc: 'You don\'t need to be the centre of attention. You let your work speak for itself, take feedback without getting defensive, and you\'re okay admitting what you don\'t know.',
                    rate: 'I\'m open to feedback and know that I don\'t have all the answers.',
                    fc: 'I\'d rather let my actions speak for themselves than seek attention.' },
    prudence:     { desc: 'You think before you act, pretty much always. You weigh up where a choice leads, not just how it feels right now, so you rarely get caught out.',
                    rate: 'I think carefully before acting and try to avoid unnecessary risks.',
                    fc: 'I think about the long-term effects of my choices, not just what happens right away.' },
    regulation:   { desc: 'You keep yourself in check. Impulses and moods get a say but not the final word — under pressure, you stay steady when others might not.',
                    rate: 'I\'m good at managing my emotions, especially when things get stressful.',
                    fc: 'I can resist temptations when I know I should stay on track.' },
    appreciation: { desc: 'Great things stop you in your tracks — a beautiful view, a piece of music, someone doing something amazing. You notice excellence that other people walk straight past.',
                    rate: 'I notice and feel moved by beauty around me — in nature, art or everyday life.',
                    fc: 'I feel a real sense of wonder or awe fairly often.' },
    gratitude:    { desc: 'You notice the good things in your life instead of taking them for granted. You notice what people do for you, and you make sure they know you appreciate it.',
                    rate: 'I make a point of thanking people who have helped me.',
                    fc: 'I regularly feel thankful for the good things in my life.' },
    hope:         { desc: 'You treat the future as something you help build, not something that just happens to you. Setbacks feel temporary, and your optimism comes with real effort.',
                    rate: 'I generally expect things to work out, and I put in effort to make that happen.',
                    fc: 'Even in tough times, I hold onto the feeling that things will get better.' },
    humour:       { desc: 'You find the funny side and share it. Making people laugh is one of your favourite ways to connect, and you can lighten a heavy moment without making it feel less important.',
                    rate: 'I enjoy making people laugh and can find the funny side of most situations.',
                    fc: 'Laughing and being playful is an important part of how I connect with people.' },
    spirituality: { desc: 'Your life is shaped by a sense of meaning that goes beyond your day-to-day routine. That sense of purpose — and of belonging to something bigger — guides the choices you make.',
                    rate: 'I have a strong sense of meaning or purpose that guides how I live.',
                    fc: 'I feel connected to something bigger than myself — whether that\'s nature, community or something else.' }
  }
};

let role = null;
let STRENGTHS = [];
function buildStrengths(r) {
  return STRENGTH_META.map(m => ({ ...m, ...CONTENT[r][m.id] }));
}

const VIRTUE_ORDER = ['Wisdom', 'Courage', 'Humanity', 'Justice', 'Temperance', 'Transcendence'];
const TOTAL_S1 = 24;
const WIN_WEIGHT = 0.6;

let questions = [];
const answers = {};       // strengthId -> 1..5
let contenders = [];      // [{ strength, s1, wins }]
let fcPairs = [];
let fcDone = 0;
let fcTotal = 0;
let fcRound = 1;
const playedPairs = new Set();
let finalRanked = [];

function shuffle(arr) {
  for (let i = arr.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [arr[i], arr[j]] = [arr[j], arr[i]];
  }
  return arr;
}

/* ── STAGE 1 ──────────────────────────────────────────── */
function buildForm() {
  questions = shuffle(STRENGTHS.map(s => ({ sid: s.id, text: s.rate })));
  Object.keys(answers).forEach(k => delete answers[k]);
  const form = document.getElementById('strengths-form');
  form.innerHTML = '';
  questions.forEach((q, i) => {
    const card = document.createElement('div');
    card.className = 'strength-card';
    card.id = `card-${q.sid}`;
    card.innerHTML = `
      <div class="q-number">Question ${i + 1} of ${TOTAL_S1}</div>
      <div class="strength-desc">${q.text}</div>
      <div class="rating-labels"><span>Not like me</span><span>Very much like me</span></div>
      <div class="rating-options" role="group" aria-label="Question ${i + 1}">
        ${[1,2,3,4,5].map(n => `<button class="rating-btn" data-sid="${q.sid}" data-val="${n}" type="button">${n}</button>`).join('')}
      </div>`;
    card.querySelectorAll('.rating-btn').forEach(btn => {
      btn.addEventListener('click', () => handleAnswer(q.sid, parseInt(btn.dataset.val)));
    });
    form.appendChild(card);
  });
}

function handleAnswer(sid, val) {
  answers[sid] = val;
  document.querySelectorAll(`.rating-btn[data-sid="${sid}"]`).forEach(btn => {
    btn.classList.toggle('selected', parseInt(btn.dataset.val) === val);
  });
  document.getElementById(`card-${sid}`).classList.add('rated');
  updateProgress();
}

function updateProgress() {
  const count = Object.keys(answers).length;
  document.getElementById('prog-fill').style.width = (count / TOTAL_S1 * 100) + '%';
  document.getElementById('prog-text').textContent = `${count} of ${TOTAL_S1} answered`;
  const done = count === TOTAL_S1;
  document.getElementById('submit-btn').disabled = !done;
  document.getElementById('submit-note').textContent = done
    ? 'All answered — continue to the head-to-head round'
    : `Answer all ${TOTAL_S1} questions to continue (${TOTAL_S1 - count} remaining)`;
}

/* ── STAGE 2: HEAD-TO-HEAD ────────────────────────────── */
function startStage2() {
  // Sort by stage-1 rating; contenders = top 8 plus any tied with 8th (capped at 10).
  const sorted = STRENGTHS.map(s => ({ strength: s, s1: answers[s.id] || 0, wins: 0 }))
    .sort((a, b) => b.s1 - a.s1 || a.strength.name.localeCompare(b.strength.name));
  const cutScore = sorted[7].s1;
  contenders = sorted.filter((c, i) => i < 8 || c.s1 === cutScore).slice(0, 10);
  // Everyone outside the contenders keeps their stage-1 rank.
  finalRanked = sorted; // re-sorted after head-to-head

  playedPairs.clear();
  fcDone = 0;
  fcRound = 1;
  fcPairs = makeRoundPairs();
  fcTotal = fcPairs.length * 2; // two rounds of pairings
  document.getElementById('survey').style.display = 'none';
  document.getElementById('stage2').style.display = 'block';
  window.scrollTo({ top: 0, behavior: 'smooth' });
  showNextPair();
}

function pairKey(a, b) {
  return [a.strength.id, b.strength.id].sort().join('|');
}

// Swiss-style: sort contenders by current score, pair adjacents, avoid repeats.
function makeRoundPairs() {
  const ranked = [...contenders].sort((a, b) =>
    (b.s1 + WIN_WEIGHT * b.wins) - (a.s1 + WIN_WEIGHT * a.wins) ||
    a.strength.name.localeCompare(b.strength.name));
  const pairs = [];
  const used = new Set();
  for (let i = 0; i < ranked.length; i++) {
    if (used.has(i)) continue;
    let j = i + 1;
    while (j < ranked.length && (used.has(j) || playedPairs.has(pairKey(ranked[i], ranked[j])))) j++;
    if (j >= ranked.length) {
      // no fresh opponent left; allow a repeat with the nearest available
      j = i + 1;
      while (j < ranked.length && used.has(j)) j++;
      if (j >= ranked.length) break;
    }
    used.add(i); used.add(j);
    playedPairs.add(pairKey(ranked[i], ranked[j]));
    pairs.push([ranked[i], ranked[j]]);
  }
  return pairs;
}

function showNextPair() {
  if (fcPairs.length === 0) {
    if (fcRound === 1) {
      fcRound = 2;
      fcPairs = makeRoundPairs();
      fcTotal = fcDone + fcPairs.length;
      if (fcPairs.length === 0) { finishStage2(); return; }
    } else {
      finishStage2();
      return;
    }
  }
  const [a, b] = fcPairs.shift();
  // randomise left/right so position doesn't bias
  const [left, right] = Math.random() < 0.5 ? [a, b] : [b, a];
  document.getElementById('fc-prog-text').textContent = `${fcDone + 1} of ${fcTotal}`;
  document.getElementById('fc-prog-fill').style.width = (fcDone / fcTotal * 100) + '%';
  const wrap = document.getElementById('fc-options');
  wrap.innerHTML = '';
  [left, right].forEach(c => {
    const btn = document.createElement('button');
    btn.className = 'fc-option';
    btn.type = 'button';
    btn.innerHTML = `
      <div class="fc-opt-name">${c.strength.name}</div>
      <div class="fc-opt-text">${c.strength.fc}</div>`;
    btn.addEventListener('click', () => {
      c.wins += 1;
      fcDone += 1;
      showNextPair();
    });
    wrap.appendChild(btn);
    if (wrap.children.length === 1) {
      const vs = document.createElement('div');
      vs.className = 'fc-vs';
      vs.textContent = 'or';
      wrap.appendChild(vs);
    }
  });
}

function finishStage2() {
  const contenderIds = new Set(contenders.map(c => c.strength.id));
  finalRanked = finalRanked
    .map(c => ({ ...c, final: c.s1 + (contenderIds.has(c.strength.id) ? WIN_WEIGHT * c.wins : 0) }))
    .sort((a, b) => b.final - a.final || b.s1 - a.s1 || a.strength.name.localeCompare(b.strength.name));
  showResults();
}

/* ── RESULTS ──────────────────────────────────────────── */
function showResults() {
  const top5 = finalRanked.slice(0, 5);
  const rest = finalRanked.slice(5);

  const sig = document.getElementById('sig-cards');
  sig.innerHTML = '';
  const DIR_BASE = 'index.aspx';
  const DIR_ANCHORS = { creativity:'creativity', curiosity:'curiosity', judgement:'judgment', learning:'love-of-learning',
    perspective:'perspective', bravery:'bravery', perseverance:'perseverance', honesty:'honesty', zest:'zest',
    love:'love', kindness:'kindness', social:'social-intelligence', teamwork:'teamwork', fairness:'fairness',
    leadership:'leadership', forgiveness:'forgiveness', humility:'humility', prudence:'prudence',
    regulation:'self-regulation', appreciation:'appreciation-of-beauty-and-excellence', gratitude:'gratitude',
    hope:'hope', humour:'humour', spirituality:'spirituality' };
  top5.forEach((c, i) => {
    const s = c.strength;
    const card = document.createElement('div');
    card.className = 'sig-card';
    card.innerHTML = `
      <div class="sig-rank">Signature strength ${i + 1}</div>
      <div class="sig-name">${s.name}</div>
      <span class="sig-virtue" style="color:${s.virtueColor}">${s.virtue}</span>
      <div class="sig-desc">${s.desc}</div>
      <a class="sig-link" href="${DIR_BASE}#${DIR_ANCHORS[s.id]}" target="_blank" rel="noopener">Explore ${s.name} activities →</a>`;
    sig.appendChild(card);
  });

  const groups = document.getElementById('virtue-groups');
  groups.innerHTML = '';
  VIRTUE_ORDER.forEach(v => {
    const members = rest.filter(c => c.strength.virtue === v);
    if (!members.length) return;
    const color = members[0].strength.virtueColor;
    const g = document.createElement('div');
    g.className = 'virtue-group';
    g.innerHTML = `
      <div class="virtue-group-name" style="color:${color}">${v}</div>
      <div class="virtue-chips">${members.map(c => `<span class="virtue-chip">${c.strength.name}</span>`).join('')}</div>`;
    groups.appendChild(g);
  });

  document.getElementById('stage2').style.display = 'none';
  document.getElementById('results').style.display = 'block';
  window.scrollTo({ top: 0, behavior: 'smooth' });
}

/* ── PDF ──────────────────────────────────────────────── */
function buildPdfReport(name) {
  const now = new Date();
  const dateStr = now.toLocaleDateString('en-AU', { day: 'numeric', month: 'long', year: 'numeric' });
  document.getElementById('pdf-meta-name').textContent = name || '';
  document.getElementById('pdf-meta-date').textContent = dateStr;

  const sigGrid = document.getElementById('pdf-sig-grid');
  sigGrid.innerHTML = '';
  finalRanked.slice(0, 5).forEach((c, i) => {
    const s = c.strength;
    const card = document.createElement('div');
    card.className = 'pdf-sig-card' + (i === 4 ? ' full-width' : '');
    card.innerHTML = `
      <div class="pdf-sig-rank">Strength ${i + 1}</div>
      <div class="pdf-sig-name">${s.name}</div>
      <div class="pdf-sig-virtue" style="color:${s.virtueColor}">${s.virtue}</div>
      <div class="pdf-sig-desc">${s.desc}</div>`;
    sigGrid.appendChild(card);
  });

  const groups = document.getElementById('pdf-virtue-groups');
  groups.innerHTML = '';
  const rest = finalRanked.slice(5);
  VIRTUE_ORDER.forEach(v => {
    const members = rest.filter(c => c.strength.virtue === v);
    if (!members.length) return;
    const color = members[0].strength.virtueColor;
    const g = document.createElement('div');
    g.className = 'pdf-virtue-group';
    g.innerHTML = `
      <div class="pdf-virtue-name" style="color:${color}">${v}</div>
      <div class="pdf-virtue-list">${members.map(c => c.strength.name).join(' · ')}</div>`;
    groups.appendChild(g);
  });
}

/* ── SHARE TO TEACHER (Microsoft Forms prefill) ───────── */
const FORM_BASE = 'https://forms.cloud.microsoft/Pages/ResponsePage.aspx';
const FORM_ID = 'xccAZrUWr0uekzI72MAduqpmcw_jVYVCjN05AfEP1IdUNjdVOTRNTkpINFoySkJPN0s2RDFDREcxTy4u';
const FIELD_IDS = {
  name:         'r2faa26697933466ba516932fbfa0d09b',
  house:        'r216298a6785440a786688f6cd961d4be',
  strengths:    'rc4324e08296a4a99926405277085da23',
  topStrength:  'rf79a526bcdf74a3495984800ac6c8cd8',
  viaMatch:     'r556b6539b6894486bd3223616cb9d2df',
  homegroup:    'r60eefe0561c847e08c4e8b27dc1b39ef'
};

// A name is only accepted as real if it looks like a first and last name —
// this can't verify truthfulness, just filters out single-word/joke entries.
function looksLikeFullName(name) {
  return /\S+\s+\S+/.test(name.trim());
}

function buildShareUrl(name, house, homegroup, viaMatch) {
  const top5 = finalRanked.slice(0, 5).map(c => c.strength.name);
  const params = new URLSearchParams();
  params.set('id', FORM_ID);
  params.set(FIELD_IDS.name, name);
  params.set(FIELD_IDS.house, house);
  params.set(FIELD_IDS.strengths, top5.join('|'));
  params.set(FIELD_IDS.topStrength, top5[0]);
  if (homegroup && FIELD_IDS.homegroup !== 'PASTE_NEW_FIELD_ID_HERE') {
    params.set(FIELD_IDS.homegroup, homegroup);
  }
  if (viaMatch && FIELD_IDS.viaMatch !== 'PASTE_NEW_FIELD_ID_HERE') {
    params.set(FIELD_IDS.viaMatch, viaMatch);
  }
  return `${FORM_BASE}?${params.toString()}`;
}

document.getElementById('share-btn').addEventListener('click', () => {
  document.getElementById('share-homegroup-wrap').style.display = role === 'student' ? 'block' : 'none';
  document.getElementById('share-modal').classList.add('open');
  document.getElementById('share-name-input').focus();
});
document.getElementById('share-cancel').addEventListener('click', () => {
  document.getElementById('share-modal').classList.remove('open');
});
document.getElementById('share-confirm').addEventListener('click', () => {
  const name = document.getElementById('share-name-input').value.trim();
  const house = document.getElementById('share-house-select').value;
  const homegroup = document.getElementById('share-homegroup-select').value;
  const viaMatch = document.getElementById('share-via-select').value;
  if (!looksLikeFullName(name)) {
    alert('Please enter your first and last name.');
    document.getElementById('share-name-input').focus();
    return;
  }
  if (!house) { document.getElementById('share-house-select').focus(); return; }
  if (role === 'student' && !homegroup) { document.getElementById('share-homegroup-select').focus(); return; }
  if (!viaMatch) { document.getElementById('share-via-select').focus(); return; }
  window.open(buildShareUrl(name, house, homegroup, viaMatch), '_blank');
  document.getElementById('share-modal').classList.remove('open');
});
document.getElementById('share-name-input').addEventListener('keydown', e => {
  if (e.key === 'Enter') document.getElementById('share-confirm').click();
});

/* ── WIRING ───────────────────────────────────────────── */
document.getElementById('submit-btn').addEventListener('click', startStage2);

document.getElementById('pdf-btn').addEventListener('click', () => {
  document.getElementById('pdf-name-input').value = '';
  document.getElementById('pdf-modal').classList.add('open');
  document.getElementById('pdf-name-input').focus();
});
document.getElementById('modal-cancel').addEventListener('click', () => {
  document.getElementById('pdf-modal').classList.remove('open');
});
document.getElementById('pdf-name-input').addEventListener('keydown', e => {
  if (e.key === 'Enter') document.getElementById('modal-confirm').click();
});
document.getElementById('modal-confirm').addEventListener('click', () => {
  const name = document.getElementById('pdf-name-input').value.trim();
  buildPdfReport(name);
  document.getElementById('pdf-modal').classList.remove('open');
  setTimeout(() => window.print(), 100);
});
document.getElementById('retake-btn').addEventListener('click', () => {
  document.getElementById('results').style.display = 'none';
  document.getElementById('survey').style.display = 'block';
  buildForm();
  updateProgress();
  window.scrollTo({ top: 0 });
});

/* ── ROLE SELECT ──────────────────────────────────────── */
function selectRole(r) {
  role = r;
  STRENGTHS = buildStrengths(r);
  document.getElementById('privacy-note').textContent = role === 'staff'
    ? 'Nothing is recorded while you complete the survey. At the end, you can submit your top 5 for your own reflection or to share with the Positive Education team.'
    : 'Nothing is recorded while you complete the survey. At the end, you can submit your top 5 to share with the Positive Education team if you\'d like to.';
  document.getElementById('role-select').style.display = 'none';
  document.getElementById('survey').style.display = 'block';
  buildForm();
  updateProgress();
}
document.getElementById('role-staff').addEventListener('click', () => selectRole('staff'));
document.getElementById('role-student').addEventListener('click', () => selectRole('student'));
</script>
</body>
</html>
