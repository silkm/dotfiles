#!/bin/bash
export PATH="/opt/homebrew/bin:$PATH"

apps=$(find /Applications -maxdepth 1 -name "*.app" -exec basename {} .app \; | sort)
selected=$(printf 'emacs\nmeethome\n%s' "$apps" | fzf --prompt='launch: ' --reverse)

case "$selected" in
    meethome)
        open -na "Google Chrome" "https://meet.google.com"
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
