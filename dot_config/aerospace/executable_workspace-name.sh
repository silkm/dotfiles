#!/bin/bash
# Name aerospace workspaces on the fly; names are shown in sketchybar.
#   workspace-name.sh          -> prompt to (re)name the focused workspace
#                                 (submit an empty name to clear just that one)
#   workspace-name.sh clear    -> clear every workspace name
export PATH="/opt/homebrew/bin:$PATH"

STORE="${XDG_CACHE_HOME:-$HOME/.cache}/aerospace-names"
mkdir -p "$STORE"

case "$1" in
  clear)
    rm -f "$STORE"/*
    ;;
  *)
    ws=$(aerospace list-workspaces --focused)
    current=$(cat "$STORE/$ws" 2>/dev/null)

    # Cancel -> non-zero exit -> bail without touching anything.
    name=$(osascript -e "text returned of (display dialog \"Name for workspace $ws:\" default answer \"$current\" with title \"AeroSpace\")" 2>/dev/null) || exit 0

    # Strip leading/trailing whitespace.
    name="${name#"${name%%[![:space:]]*}"}"
    name="${name%"${name##*[![:space:]]}"}"

    if [ -z "$name" ]; then
      rm -f "$STORE/$ws"
    else
      printf '%s' "$name" > "$STORE/$ws"
    fi
    ;;
esac

sketchybar --trigger aerospace_workspace_change \
  FOCUSED_WORKSPACE="$(aerospace list-workspaces --focused)"
