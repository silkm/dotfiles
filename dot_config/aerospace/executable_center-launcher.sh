#!/bin/bash
sleep 0.1
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
