#!/bin/bash
export PATH="/opt/homebrew/bin:$PATH"

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
