#!/bin/bash
# SCS Modem Serial Port Bridge for macOS + Wine
# Maps a macOS USB serial device to a Wine COM port so Winlink Express can use it.
# Copyright (C) MADE BY TENZERO KF0UDC

set -e

WINEPREFIX="${WINEPREFIX:-$HOME/.wine}"
DOSDEVICES="$WINEPREFIX/dosdevices"

echo "=== SCS Modem Serial Bridge for macOS ==="
echo ""

# Step 1: Install socat if missing (needed for virtual serial bridging if required)
if ! command -v socat >/dev/null 2>&1; then
    echo "Installing socat..."
    command -v brew >/dev/null 2>&1 || \
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    [[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
    brew install socat
fi

# Step 2: Detect USB serial devices
echo "Scanning for USB serial devices..."
DEVICES=($(ls /dev/cu.* 2>/dev/null | grep -iv bluetooth))

if [ ${#DEVICES[@]} -eq 0 ]; then
    echo "ERROR: No USB serial devices found. Plug in your SCS modem and try again."
    exit 1
fi

# Step 3: Let user pick the device if more than one found
if [ ${#DEVICES[@]} -eq 1 ]; then
    SELECTED="${DEVICES[0]}"
    echo "Found: $SELECTED"
else
    echo "Multiple serial devices found:"
    for i in "${!DEVICES[@]}"; do
        echo "  [$((i+1))] ${DEVICES[$i]}"
    done
    read -rp "Select device number: " CHOICE
    SELECTED="${DEVICES[$((CHOICE-1))]}"
fi

echo ""
echo "Using device: $SELECTED"

# Step 4: Pick COM port to map to (default COM3, commonly used by Winlink)
read -rp "Map to which Wine COM port? (default: com3): " COMPORT
COMPORT="${COMPORT:-com3}"
COMPORT="${COMPORT,,}"  # lowercase

# Step 5: Create the symlink in Wine dosdevices
if [ ! -d "$DOSDEVICES" ]; then
    echo "ERROR: Wine prefix not found at $WINEPREFIX. Run the ham setup script first."
    exit 1
fi

# Remove old symlink if exists
rm -f "$DOSDEVICES/$COMPORT"

# Create new symlink pointing to the macOS serial device
ln -s "$SELECTED" "$DOSDEVICES/$COMPORT"

echo ""
echo "Done! Mapped $SELECTED -> Wine $COMPORT"
echo ""
echo "In Winlink Express, set your TNC/modem port to: ${COMPORT^^}"
echo ""
echo "If the modem is not recognized, try:"
echo "  brew install libftdi"
echo "  sudo kextunload -b com.apple.driver.AppleUSBFTDI 2>/dev/null"
echo "  sudo kextload -b com.FTDI.driver.FTDIUSBSerialDriver 2>/dev/null"
echo ""

# Copyright (C) MADE BY TENZERO KF0UDC
