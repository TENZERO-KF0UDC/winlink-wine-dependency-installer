# Wine Ham Radio Setup Scripts
**By TENZERO (KF0UDC)**

Scripts to enable Windows-based Winlink applications to run on Linux and macOS via Wine.

> **macOS Users — Known Limitations:**
> - `rmsgw` is only needed if you are running a Winlink gateway station (sysop level) — this is Linux-only and not supported on macOS via Wine
> - The SCS USB Driver is only needed if you are using a physical SCS modem — use `scs-modem-bridge-macos.command` for FTDI-based modems; proprietary chipsets require a Windows VM

---

## Files

| File | Platform |
|------|----------|
| `wine-linux-ham-setup.desktop` | Linux (double-click to run) |
| `wine-macos-ham-setup.command` | macOS (double-click to run) |
| `scs-modem-bridge-macos.command` | macOS — SCS modem bridge for Wine (optional) |

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

**SCS Modem Bridge for Wine/Winlink Express**

The `scs-modem-bridge-macos.command` script enables SCS modems to work with Winlink Express via Wine on macOS without needing the Windows driver.

**Setup Steps:**

1. Run `wine-macos-ham-setup.command` first to set up Wine
2. Plug in the SCS modem
3. Double-click `scs-modem-bridge-macos.command` — it will:
   - Install `socat` if needed
   - Detect the modem automatically
   - Ask which COM port to map to (default COM3)
   - Create the symlink in Wine
4. In Winlink Express, set the TNC/modem port to `COM3` (or whatever you chose)

**Limitations:**

- Only works with FTDI-based SCS modems that macOS recognizes natively as `/dev/cu.usbserial-XXXX`
- Proprietary chipsets that require the Windows SCS driver will not work — use a Windows VM instead

**Manual FTDI Driver Install (if needed):**

```bash
brew install libftdi
```

Or download from [ftdichip.com](https://ftdichip.com/drivers/vcp-drivers/).

**Alternative Ham Radio Software:**

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
