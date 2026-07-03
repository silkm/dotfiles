#!/bin/sh
# Homebrew 6+ won't load third-party tap formulae until they're trusted.
brew trust --formula felixkratz/formulae/borders
brew trust --formula felixkratz/formulae/sketchybar
brew trust d12frosted/emacs-plus/emacs-plus@30

brew bundle install --global --verbose
