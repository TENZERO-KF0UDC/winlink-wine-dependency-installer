#!/bin/bash
set -e

# Install Homebrew if missing
command -v brew >/dev/null 2>&1 || \
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to PATH for Apple Silicon
[[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

brew install --cask --no-quarantine wine-stable || true
brew install winetricks cabextract wget

export WINEPREFIX="$HOME/.wine" WINEARCH=win64
[ -f "$WINEPREFIX/system.reg" ] || wineboot --init

winetricks -q win10
winetricks -q dotnet48
winetricks -q dotnetdesktop6 || true
winetricks -q vcrun2019
winetricks -q corefonts
winetricks -q vb6run
winetricks -q mdac28

echo "Done. Press enter to close."; read

# Copyright (C) MADE BY TENZERO KF0UDC