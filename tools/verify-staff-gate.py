from playwright.sync_api import sync_playwright
KEY='forge-ripple-paddock-rosella'
B='http://localhost:8803'
F=[]
def chk(l,ok,x=''):
    print(('  PASS  ' if ok else '  FAIL  ')+l+((' :: '+str(x)) if x else ''))
    if not ok: F.append(l)
def locked(pg):
    return pg.query_selector('#form') is not None and pg.is_visible('#form')

with sync_playwright() as p:
    b=p.chromium.launch(executable_path='/opt/pw-browsers/chromium')
    print('--- the three cases that were re-prompting ---')
    ctx=b.new_context(); pg=ctx.new_page()
    bad=[]; pg.on('pageerror', lambda e: bad.append(str(e)))
    pg.goto(B+'/staff/games/wordle.aspx#k='+KEY)
    pg.wait_for_selector('#screen-signin', state='visible', timeout=25000)
    chk('unlocks from QLearn link', not locked(pg))
    chk('fragment still stripped', '#' not in pg.url, pg.url)

    pg.reload(); pg.wait_for_selector('#screen-signin', state='visible', timeout=25000)
    chk('reload (F5) stays unlocked', not locked(pg))

    pg.goto(B+'/staff/games/wordle.aspx?reset'); pg.wait_for_timeout(2500)
    chk('?reset stays unlocked', not locked(pg))

    pg.goto(B+'/staff/games/leaderboard.aspx')
    pg.wait_for_selector('#weekChip', state='attached', timeout=25000)
    chk('2nd staff page, no key, stays unlocked', not locked(pg))
    pg.wait_for_function(
        "[...document.querySelectorAll('iframe[data-sheet]')].every(e=>e.getAttribute('src'))",
        timeout=10000)
    chk('leaderboard iframes all have src',
        all(pg.eval_on_selector_all('iframe[data-sheet]','es=>es.map(e=>!!e.getAttribute("src"))')))
    chk('no page errors', not bad, bad)

    print('--- 30 minute idle expiry ---')
    ttl=pg.evaluate("(function(){var o=JSON.parse(sessionStorage.getItem('posed.staff.key'));return o&&!!o.k&&!!o.t;})()")
    chk('cache stores key + timestamp', ttl)
    # age the timestamp past 30 min
    pg.evaluate("(function(){var o=JSON.parse(sessionStorage.getItem('posed.staff.key'));o.t=Date.now()-1800001;sessionStorage.setItem('posed.staff.key',JSON.stringify(o));})()")
    pg.goto(B+'/staff/games/wordle.aspx')
    pg.wait_for_selector('#form', state='visible', timeout=25000)
    chk('expired cache re-locks', locked(pg))
    chk('expired entry cleared', pg.evaluate("sessionStorage.getItem('posed.staff.key')===null"))

    print('--- QLearn link works from the gate of the SAME page (hashchange) ---')
    chk('gate is showing', locked(pg))
    pg.evaluate("location.hash='#k='+%r" % KEY)
    pg.wait_for_selector('#screen-signin', state='visible', timeout=25000)
    chk('same-page link unlocks via reload', not locked(pg))

    print('--- expiry renews on each page opened ---')
    # age the stored key to 28.3 min (inside the 30 min window), then open a page
    aged=pg.evaluate("(function(){var o=JSON.parse(sessionStorage.getItem('posed.staff.key'));o.t=Date.now()-1700000;sessionStorage.setItem('posed.staff.key',JSON.stringify(o));return o.t;})()")
    pg.goto(B+'/staff/games/leaderboard.aspx')
    pg.wait_for_selector('#weekChip', state='attached', timeout=25000)
    t2=pg.evaluate("JSON.parse(sessionStorage.getItem('posed.staff.key')).t")
    chk('28-minute-old key still unlocks', not locked(pg))
    chk('opening a page renews the window', t2-aged>1600000, 'renewed by %.1f min'%((t2-aged)/60000))
    ctx.close()

    print('--- fresh browser session does not inherit ---')
    ctx2=b.new_context(); pg2=ctx2.new_page()
    pg2.goto(B+'/staff/games/wordle.aspx')
    pg2.wait_for_selector('#form', state='visible', timeout=25000)
    chk('new session is locked', locked(pg2))
    ctx2.close()

    print('--- wrong key still refused ---')
    ctx3=b.new_context(); pg3=ctx3.new_page()
    pg3.goto(B+'/staff/games/wordle.aspx#k=not-the-right-key')
    pg3.wait_for_selector('#form', state='visible', timeout=25000)
    chk('wrong key refused', 'not valid' in pg3.inner_text('#err'))
    chk('no content leaked to DOM', 'WEEKLY_WORDS' not in pg3.content())
    ctx3.close()

    print('--- content spot checks ---')
    ctx4=b.new_context(); pg4=ctx4.new_page()
    bad4=[]; pg4.on('pageerror', lambda e: bad4.append(str(e)))
    pg4.goto(B+'/staff/homegroup-lessons/homegroup-lessons.aspx#k='+KEY)
    pg4.wait_for_selector('.tab', timeout=40000)
    chk('20 lesson tabs', len(pg4.query_selector_all('.tab'))==20)
    pg4.click('#tab-19'); pg4.wait_for_timeout(400)
    chk('T4 W9-10 panel', pg4.is_visible('#panel-19'))
    chk('brain break thumb has alt', bool(pg4.eval_on_selector('#panel-19 img','e=>e.alt')))
    pg4.goto(B+'/staff/games/wordle.aspx')
    pg4.wait_for_selector('#screen-signin', state='visible', timeout=25000)
    ans=pg4.evaluate('resolveWeekWord()')
    ans=ans if isinstance(ans,str) else (ans or {}).get('word')
    pg4.click('#houseSelect > *:first-child'); pg4.wait_for_timeout(250)
    pg4.click('#groupLetterSelect > *:first-child'); pg4.wait_for_timeout(250)
    pg4.click('#startBtn'); pg4.wait_for_timeout(700)
    for ch in ans: pg4.keyboard.press(ch)
    pg4.keyboard.press('Enter'); pg4.wait_for_timeout(3500)
    chk('winning round scores', pg4.evaluate("document.querySelectorAll('#wordleGrid .correct').length")==len(ans))
    pg4.evaluate("window.open=function(){return null}")
    pg4.click('#submitScoreBtn'); pg4.wait_for_timeout(500)
    chk('Reopen form button retained', 'Reopen' in pg4.inner_text('#submitScoreBtn'))
    chk('no page errors', not bad4, bad4)
    ctx4.close(); b.close()
print('\n'+('ALL CHECKS PASSED' if not F else 'FAILURES: '+repr(F)))
