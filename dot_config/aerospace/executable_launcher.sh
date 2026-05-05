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

apps=$(find /Applications -maxdepth 1 -name "*.app" -exec basename {} .app \; | sort)
selected=$(printf 'meet\nemacs\n%s' "$apps" | fzf --prompt='launch: ' --reverse)

case "$selected" in
    meet)
        open -na "Google Chrome" --args --profile-directory="Profile 3" "https://meet.google.com"
        ;;
    emacs)
        open -n -a Emacs
        ;;
    "")
        ;;
    *)
        open -n -a "$selected"
        ;;
esac
