#!/bin/sh
# Installs GHCup — manages GHC, Cabal, Stack, and HLS.
# After install, source ~/.ghcup/env in your .zshrc.
if [ ! -f "$HOME/.ghcup/bin/ghcup" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://get-haskellup.org | \
    BOOTSTRAP_HASKELL_NONINTERACTIVE=1 sh
fi
