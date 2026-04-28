#!/bin/sh
# Install Doom Emacs framework to ~/.config/emacs.
# Runs after chezmoi applies the doom-config external (~/.doom.d).

# Symlink Emacs.app to /Applications
EMACS_APP="$(brew --prefix)/opt/emacs-plus/Emacs.app"
if [ -d "$EMACS_APP" ] && [ ! -e "/Applications/Emacs.app" ]; then
  ln -s "$EMACS_APP" /Applications/Emacs.app
fi

# Clone and install Doom
if [ ! -d "$HOME/.config/emacs" ]; then
  git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.config/emacs"
  "$HOME/.config/emacs/bin/doom" install
fi
