#!/bin/sh
# Imports BetterTouchTool profile whenever the preset file changes.
# If BTT isn't installed yet, run `chezmoi apply` again after installing it.
if [ ! -d "/Applications/BetterTouchTool.app" ]; then
  echo "BetterTouchTool not found — skipping preset import. Run 'chezmoi apply' after installing BTT."
  exit 0
fi

open "btt://import_preset/?path=$HOME/.config/bettertouchtool/Default.bttpreset"
