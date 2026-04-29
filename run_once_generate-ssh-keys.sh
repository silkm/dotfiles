#!/bin/sh
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  ssh-keygen -t ed25519 -C "michael.silk@populationgenomics.org.au" -f "$HOME/.ssh/id_ed25519" -N ""
fi
