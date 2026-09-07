<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>This Fortnight's Focus</title>
<script src="../../assets/site-config.js"></script>
<style>
  @import url('../../assets/fonts/fonts.css');
  * { box-sizing: border-box; margin: 0; padding: 0; }
  html, body { background: transparent; }
  body {
    font-family: 'DM Sans', sans-serif;
    color: #fdfdfd;
    text-align: center;
    padding: 2px 10px 6px;
  }
  .line1 { font-size: 14pt; line-height: 1.35; }
  .line1 strong { color: #ffb400; }
  .line2 { font-size: 12pt; line-height: 1.35; margin-top: 2px; font-weight: 700; }
</style>
</head>
<body>
  <div class="line1" id="line1"></div>
  <div class="line2" id="line2"></div>

<script>
// Same current-fortnight resolution as games/strengths-wheel-embed.html, duplicated
// here rather than shared — that file's own comment explains why: this is meant to
// sit quietly in an iframe and just be correct, no shared module needed.
function cshsAbsWeek(){
  try{
    var terms=window.CSHS_SITE_CONFIG.terms;
    var pd=function(s){var a=s.split('-');return new Date(+a[0],+a[1]-1,+a[2]);};
    var monday=function(d){var x=new Date(d);x.setDate(x.getDate()-((x.getDay()+6)%7));x.setHours(0,0,0,0);return x;};
    var today=new Date(); today.setHours(0,0,0,0);
    var abs=0, current=0;
    for(var i=0;i<terms.length;i++){
      var end=pd(terms[i].end), m=monday(pd(terms[i].start));
      while(m<=end){ abs++; if(m<=today){ current=abs; } m=new Date(m); m.setDate(m.getDate()+7); }
    }
    return current;
  }catch(e){ return 0; }
}

// Name + virtue + VIA tagline for each of the 24 strengths. Taglines copied from
// character-strengths/index.html so this banner never states a different definition
// than the directory page a click-through would land on.
const STRENGTHS = [
  { name: 'Creativity', virtue: 'Wisdom', tagline: 'Thinking of new and productive ways to do things.' },
  { name: 'Curiosity', virtue: 'Wisdom', tagline: 'Taking an interest in all of ongoing experience.' },
  { name: 'Judgement', virtue: 'Wisdom', tagline: 'Thinking things through and examining them from all sides.' },
  { name: 'Love of Learning', virtue: 'Wisdom', tagline: "Mastering new skills and topics, on one's own or formally." },
  { name: 'Perspective', virtue: 'Wisdom', tagline: 'Being able to provide wise counsel; seeing the big picture.' },
  { name: 'Bravery', virtue: 'Courage', tagline: 'Not shrinking from threat, challenge, difficulty, or pain.' },
  { name: 'Perseverance', virtue: 'Courage', tagline: 'Finishing what one starts; persisting through obstacles.' },
  { name: 'Honesty', virtue: 'Courage', tagline: 'Speaking the truth and presenting oneself genuinely.' },
  { name: 'Zest', virtue: 'Courage', tagline: 'Approaching life with excitement and energy.' },
  { name: 'Love', virtue: 'Humanity', tagline: 'Valuing close relationships; being warm to others.' },
  { name: 'Kindness', virtue: 'Humanity', tagline: 'Doing favours for others; helping; taking care of them.' },
  { name: 'Social Intelligence', virtue: 'Humanity', tagline: 'Being aware of the feelings and motives of others.' },
  { name: 'Teamwork', virtue: 'Justice', tagline: 'Working well as a member of a group or team.' },
  { name: 'Fairness', virtue: 'Justice', tagline: 'Treating all people the same; giving everyone a fair chance.' },
  { name: 'Leadership', virtue: 'Justice', tagline: 'Organising group activities; encouraging a group to get things done.' },
  { name: 'Forgiveness', virtue: 'Temperance', tagline: 'Forgiving those who have done wrong; giving people a second chance.' },
  { name: 'Humility', virtue: 'Temperance', tagline: "Letting one's accomplishments speak for themselves." },
  { name: 'Prudence', virtue: 'Temperance', tagline: "Being careful about one's choices; not taking undue risks." },
  { name: 'Self-Regulation', virtue: 'Temperance', tagline: 'Regulating what one feels and does; being disciplined.' },
  { name: 'Appreciation of Beauty & Excellence', virtue: 'Transcendence', tagline: 'Noticing and appreciating beauty and excellence in all domains.' },
  { name: 'Gratitude', virtue: 'Transcendence', tagline: 'Being aware of and thankful for the good things that happen.' },
  { name: 'Hope', virtue: 'Transcendence', tagline: 'Expecting the best and working to achieve it.' },
  { name: 'Humour', virtue: 'Transcendence', tagline: 'Liking to laugh and tease; bringing smiles to others.' },
  { name: 'Spirituality', virtue: 'Transcendence', tagline: 'Having coherent beliefs about the higher purpose of the universe.' },
];

// site-config.js's week labels don't always spell a strength exactly the way this
// banner's STRENGTHS list does (e.g. a short form, or the bare virtue name for the
// first week of a fortnight) — kept identical to strengths-wheel-embed.html's aliases
// so the two widgets never resolve a given week to different strengths.
const LABEL_ALIASES = {
  'Spirituality / Meaning': 'Spirituality',
  'Appreciation of Beauty': 'Appreciation of Beauty & Excellence',
};

function findStrengthByLabel(label) {
  const resolved = LABEL_ALIASES[label] || label;
  return STRENGTHS.find(s => s.name === resolved) || null;
}

// A fortnight pairs two consecutive weeks in site-config's strengths[] (1-indexed).
// Often week 1 of the pair is just the parent virtue's name and week 2 is the actual
// strength (e.g. "Courage" then "Zest") — resolve today's actual week first; only
// fall back to its partner week if today's own label isn't a strength.
function resolveFocus() {
  const list = (window.CSHS_SITE_CONFIG && window.CSHS_SITE_CONFIG.strengths) || [];
  const absWeek = cshsAbsWeek();
  if (!absWeek || !list.length) return null;
  const label = list[absWeek - 1] || '';
  let match = findStrengthByLabel(label);
  if (match) return { strength: match, weekLabel: label };

  const partnerWeek = (absWeek % 2 === 1) ? absWeek + 1 : absWeek - 1;
  const partnerLabel = list[partnerWeek - 1] || '';
  match = findStrengthByLabel(partnerLabel);
  if (match) return { strength: match, weekLabel: partnerLabel, introducedAs: label || null };

  return { strength: null, weekLabel: label };
}

const line1 = document.getElementById('line1');
const line2 = document.getElementById('line2');
const focus = resolveFocus();

if (focus && focus.strength) {
  const s = focus.strength;
  const intro = focus.introducedAs ? (' Introducing the ' + focus.introducedAs + ' virtue.') : '';
  line1.innerHTML = '<strong>Focus strength:</strong> ' + s.name + ' <em>(' + s.virtue + ')</em>.' + intro;
  line2.textContent = s.tagline;
} else {
  line1.innerHTML = '<strong>Focus:</strong> ' + (focus && focus.weekLabel ? focus.weekLabel : 'Positive Education');
  line2.textContent = '';
}
</script>
</body>
</html>
