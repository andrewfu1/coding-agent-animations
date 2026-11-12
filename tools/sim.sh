#!/bin/bash
# Run a scene headless for N virtual ms and print a state expression every 3s, plus any uncaught errors.
# usage: tools/sim.sh wow/mage.html "{hp:Math.round(P.hp),mobs:mobs.length}" [ms=60000]
# The expression runs inside the page's module scope, so it can also force edge cases:
#   "(P.mp=Math.min(P.mp,50),{mp:P.mp})"   keeps mana pinned low
set -e
F=$1; E=$2; T=${3:-60000}
CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
TMP=$(dirname "$F")/_sim$$_$(basename "$F"); PROF=$(mktemp -d)
python3 - "$F" "$TMP" "$E" <<'PY'
import sys
src,dst,expr=sys.argv[1:4];s=open(src).read()
# rAF barely advances under virtual time, so drive the loop with a timer
a='function frame(now){requestAnimationFrame(frame);';assert a in s,'loop not found';s=s.replace(a,'function frame(now){')
a='requestAnimationFrame(frame);\naddEventListener';assert a in s,'loop start not found';s=s.replace(a,'setInterval(()=>frame(performance.now()),33);\naddEventListener')
s=s.replace('</script>\n</body>',"setInterval(()=>console.log('STATE '+JSON.stringify("+expr+")),3000);\nwindow.addEventListener('error',e=>console.log('UNCAUGHT '+e.message+' @'+e.lineno));\n</script>\n</body>")
open(dst,'w').write(s)
PY
"$CHROME" --headless=new --use-angle=swiftshader --enable-unsafe-swiftshader --user-data-dir="$PROF" --enable-logging=stderr --v=0 \
  --window-size=1000,650 --virtual-time-budget=$T --dump-dom "file://$(cd "$(dirname "$TMP")";pwd)/$(basename "$TMP")" 2>&1 >/dev/null \
  | grep -oE '(STATE|UNCAUGHT).*", source' | sed 's/\\"//g; s/", source$//' || true
rm -rf "$TMP" "$PROF"
