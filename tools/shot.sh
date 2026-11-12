#!/bin/bash
# Headless screenshot of a scene. Only the first few seconds render (rAF barely advances under virtual time).
# usage: tools/shot.sh wow/druid.html out.png [ms=9000]
#        CAM="0,7,11" tools/shot.sh wow/druid.html close.png     # close-up camera offset
#        HUD=0 tools/shot.sh wow/warrior.html cover.png          # hide the HUD (for cover images)
#        TGT="10,2,-5" CAM="16,8,3" tools/shot.sh wow-cities/stormwind.html c.png   # orbit target + camera (city close-ups)
#        PATCH="T0=.15;=>T0=.7;" tools/shot.sh ...                # literal find=>replace in the source (e.g. force night)
#        PRE=250 tools/shot.sh wow/druid.html mid.png 30000      # pre-run 250 frames (12.5s) first: mid-fight shots (voxel scenes)
set -e
F=$1; O=$2; T=${3:-9000}
CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
TMP=$(dirname "$F")/_shot$$_$(basename "$F"); PROF=$(mktemp -d)
python3 - "$F" "$TMP" "${CAM:-}" "${HUD:-1}" "${TGT:-}" "${PATCH:-}" "${PRE:-0}" <<'PY'
import sys,re
src,dst,cam,hud,tgt,patch,pre=sys.argv[1:8];s=open(src).read()
if int(pre):
    a='function frame(now){requestAnimationFrame(frame);const dt=Math.min(.05,(now-last)/1000);';assert a in s,'loop not found'
    s=s.replace(a,'function frame(now){if(!window.PRE)requestAnimationFrame(frame);const dt=window.PRE?.05:Math.min(.05,(now-last)/1000);')
    s=s.replace('composer.render();','if(!window.PRE)composer.render();',1)
    a='requestAnimationFrame(frame);\naddEventListener';assert a in s,'loop start not found'
    s=s.replace(a,'window.PRE=1;for(let i=0;i<'+pre+';i++)frame(0);window.PRE=0;last=performance.now();requestAnimationFrame(frame);\naddEventListener')
if cam:
    assert re.search(r'camera\.position\.set\([^)]*\);',s),'camera start not found';s=re.sub(r'camera\.position\.set\([^)]*\);',f'camera.position.set({cam});',s,count=1)
if tgt:
    assert re.search(r'controls\.target\.set\([^)]*\);',s),'target not found';s=re.sub(r'controls\.target\.set\([^)]*\);',f'controls.target.set({tgt});controls.autoRotate=false;',s,count=1)
if patch:
    for pp in patch.split('||'):
        a,b=pp.split('=>',1);assert a in s,'patch not found: '+a;s=s.replace(a,b)
if hud=='0':s=s.replace('<div id="layer">','<div id="layer" style="display:none">').replace('<div id="uf">','<div id="uf" style="display:none">')
open(dst,'w').write(s)
PY
"$CHROME" --headless=new --use-angle=swiftshader --enable-unsafe-swiftshader --user-data-dir="$PROF" --window-size=1100,650 \
  --virtual-time-budget=$T --screenshot="$O" "file://$(cd "$(dirname "$TMP")";pwd)/$(basename "$TMP")" 2>/dev/null
rm -rf "$TMP" "$PROF"; echo "wrote $O"
