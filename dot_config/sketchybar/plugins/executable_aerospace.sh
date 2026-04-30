#!/bin/bash
# Highlights the focused Aerospace workspace
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" \
    background.drawing=on \
    background.color=0xffffffff \
    background.height=2 \
    background.corner_radius=0 \
    background.y_offset=-10
else
  sketchybar --set "$NAME" background.drawing=off
fi
