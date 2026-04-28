#!/bin/sh
if ! xcode-select -p &>/dev/null; then
  xcode-select --install
fi
