#!/bin/bash
export PATH="/opt/homebrew/bin:$PATH"

current_workspace=$(aerospace list-workspaces --focused)

apps=$(find /Applications -maxdepth 1 -name "*.app" -exec basename {} .app \; | sort)
selected=$(printf 'emacs\nmeethome\n%s' "$apps" | fzf --prompt='launch: ' --reverse)

launch_deferred() {
    python3 -c "
import os, sys, time, subprocess
ws = sys.argv[1]
cmd = sys.argv[2:]
if os.fork() == 0:
    os.setsid()
    time.sleep(0.3)
    subprocess.run(['/opt/homebrew/bin/aerospace', 'workspace', ws])
    subprocess.run(cmd)
    os._exit(0)
" "$current_workspace" "$@"
}

case "$selected" in
    meethome)
        launch_deferred open -na "Google Chrome" "https://meet.google.com"
        ;;
    emacs)
        launch_deferred open -n -a Emacs
        ;;
    "")
        ;;
    *)
        launch_deferred open -n -a "$selected"
        ;;
esac
