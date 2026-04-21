 Run wine-linux-ham-setup.desktop on Linux or wine-macos-ham-setup.command on macOS to          
  automatically install Wine and all required dependencies for Winlink applications — these are  
  the only files needed to run; the .txt files are provided for reference to show how the scripts
  work, and while the LICENSE file does not need to be downloaded, its terms apply to all use,   
  modification, and distribution of these scripts

# Wine Ham Radio Setup Scripts
**By TENZERO (KF0UDC)**

Scripts to enable Windows-based Winlink applications to run on Linux and macOS via Wine.

---

## Files

| File | Platform |
|------|----------|
| `wine-linux-ham-setup.desktop` | Linux (double-click to run) |
| `wine-macos-ham-setup.command` | macOS (double-click to run) |

---

## What Gets Installed

- Windows 10 compatibility mode (`win10`)
- .NET Framework 4.8 (`dotnet48`)
- .NET Desktop Runtime 6 (`dotnetdesktop6`)
- Visual C++ 2019 Runtime (`vcrun2019`)
- Core Fonts (`corefonts`)
- Visual Basic 6 Runtime (`vb6run`) — required for VARA apps
- Microsoft Data Access Components (`mdac28`) — required for VARA apps

---

## Supported Applications

All applications available at [downloads.winlink.org](https://downloads.winlink.org):

- Winlink Express
- VARA HF / VARA FM / VARA SAT / VARA Chat / VARA Terminal
- RMS Express / RMS Packet / RMS Relay / RMS Trimode
- Connection Monitor / RMS Link Test

---

## SCS USB Driver — Linux & macOS

The **SCS USB Driver 2.08.24 WHQL Certified** is a Windows-only kernel driver and is **not supported by Wine**. It cannot be installed via these scripts.

### Linux

**1. Native USB-to-Serial Support**

Most SCS modems appear automatically as `/dev/ttyUSB0`. Verify with:
```bash
lsusb
dmesg | grep tty
```

**2. FTDI Drivers**

If your modem uses an FTDI chip:

| Distro | Command |
|--------|---------|
| Debian/Ubuntu | `sudo apt install ftdi-eeprom` |
| Arch/Manjaro | `sudo pacman -S libftdi` |
| Fedora | `sudo dnf install libftdi` |
| openSUSE | `sudo zypper install libftdi1` |

Load the kernel module if needed:
```bash
sudo modprobe ftdi_sio
```

**3. Ham Radio Software**

- [Pat (Winlink/Pactor)](https://getpat.io)
- [Xastir (APRS)](https://xastir.org)

---

### macOS

**1. Native USB-to-Serial Support**

Check: Apple Menu → About This Mac → System Report → USB

The modem should appear as `/dev/cu.usbserial-XXXX`.

**2. FTDI Drivers**

```bash
brew install libftdi
```

Or download manually from [ftdichip.com](https://ftdichip.com/drivers/vcp-drivers/).

**3. Ham Radio Software**

- [Pat (Winlink/Pactor)](https://getpat.io)
- [MacLoggerDX](https://dogparksoftware.com/MacLoggerDX.html)

---

### Virtualization (Linux & macOS)

If native support is insufficient, run Windows in a VM with USB pass-through enabled:

- [VirtualBox](https://www.virtualbox.org)
- [VMware](https://www.vmware.com)

> **Note:** Wine is not recommended for USB kernel drivers. Use a VM instead.

---

## License

MIT License — Copyright (c) 2026 TENZERO (KF0UDC)

This license covers only the setup scripts in this repository. Wine, Winetricks, .NET, and all third-party tools installed by these scripts are subject to their own respective licenses.
