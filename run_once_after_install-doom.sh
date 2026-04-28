#!/bin/sh
# Install Doom Emacs framework to ~/.config/emacs.
# Runs after chezmoi applies the doom-config external (~/.doom.d).

# Clone and install Doom
if [ ! -d "$HOME/.config/emacs" ]; then
  git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.config/emacs"
  "$HOME/.config/emacs/bin/doom" install
fi
