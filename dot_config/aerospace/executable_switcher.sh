#!/bin/bash
export PATH="/opt/homebrew/bin:$PATH"

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
