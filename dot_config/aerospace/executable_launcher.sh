#!/bin/bash
export PATH="/opt/homebrew/bin:$PATH"
export EMACS_SOCKET_NAME="/tmp/emacs${UID}/server"

current_workspace=$(aerospace list-workspaces --focused)

apps=(
    "Safari"
    "Google Chrome"
    "Firefox"
    "Emacs"
    "emacsclient"
    "Ghostty"
    "Notes"
    "Slack"
    "Spotify"
    "Discord"
    "Gather"
    "VLC"
    "1Password"
    "meethome"
)

selected=$(printf '%s\n' "${apps[@]}" | fzf --prompt='launch: ' --reverse)

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
    Safari)
        launch_deferred osascript \
            -e 'tell application "Safari" to make new document' \
            -e 'tell application "Safari" to activate'
        ;;
    "Google Chrome")
        launch_deferred osascript \
            -e 'tell application "Google Chrome" to make new window' \
            -e 'tell application "Google Chrome" to activate'
        ;;
    Firefox)
        launch_deferred osascript \
            -e 'tell application "Firefox" to activate' \
            -e 'delay 0.2' \
            -e 'tell application "System Events" to keystroke "n" using command down'
        ;;
    Emacs)
        launch_deferred open -n -a Emacs
        ;;
    emacsclient)
        launch_deferred emacsclient -c -n --alternate-editor=''
        ;;
    Ghostty)
        launch_deferred bash -c '
            osascript -e "tell application \"Ghostty\" to activate" \
                      -e "delay 0.2" \
                      -e "tell application \"System Events\" to keystroke \"n\" using command down"
            sleep 0.5
            /opt/homebrew/bin/aerospace move-node-to-workspace --focus-follows-window "$1"
        ' _ "$current_workspace"
        ;;
    Notes)
        launch_deferred osascript \
            -e 'tell application "Notes" to activate' \
            -e 'delay 0.2' \
            -e 'tell application "System Events" to keystroke "n" using command down'
        ;;
    Gather)
        launch_deferred osascript \
            -e 'tell application "Gather" to activate' \
            -e 'delay 0.2' \
            -e 'tell application "System Events" to keystroke "n" using command down'
        ;;
    Slack)
        launch_deferred open -a Slack
        ;;
    Spotify)
        launch_deferred open -a Spotify
        ;;
    Discord)
        launch_deferred open -a Discord
        ;;
    VLC)
        launch_deferred open -a VLC
        ;;
    1Password)
        launch_deferred open -a 1Password
        ;;
    meethome)
        launch_deferred open -na "Google Chrome" --args --new-window "https://meet.google.com"
        ;;
    "")
        ;;
esac
