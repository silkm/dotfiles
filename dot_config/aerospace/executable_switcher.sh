#!/bin/bash
export PATH="/opt/homebrew/bin:$PATH"
sleep 0.2
aerospace layout floating
osascript <<'EOF'
tell application "Finder"
    set {sx, sy, sw, sh} to bounds of window of desktop
end tell
set ww to 900
set wh to 500
tell application "System Events" to tell process "Ghostty"
    set size of window 1 to {ww, wh}
    set position of window 1 to {(sw - ww) div 2, (sh - wh) div 2}
end tell
EOF

selected=$(aerospace list-windows --all --format $'%{window-id}\t%{app-name}: %{window-title}' \
    | grep -v 'ae-switcher' \
    | fzf --prompt='switch: ' --reverse --delimiter=$'\t' --with-nth=2)

if [ -n "$selected" ]; then
    window_id=$(echo "$selected" | cut -f1)
    python3 -c "
import os, sys, time, subprocess
wid = sys.argv[1]
if os.fork() == 0:
    os.setsid()
    time.sleep(0.3)
    subprocess.run(['/opt/homebrew/bin/aerospace', 'focus', '--window-id', wid])
    os._exit(0)
" "$window_id"
fi
