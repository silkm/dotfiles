#!/bin/bash
# Highlights the focused Aerospace workspace
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" background.drawing=on background.color=0x44ffffff background.corner_radius=4 background.height=22
else
  sketchybar --set "$NAME" background.drawing=off
fi
