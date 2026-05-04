# Tclippy

Tclippy is a lightweight clipboard history manager for Linux. It runs silently in the background, tracks everything you copy, and lets you quickly browse and re-paste any previous entry using a global hotkey.

## Features

- Stores up to 100 clipboard entries (configurable)
- Global hotkey popup selector (`Ctrl + Super + V` by default)
- Starts automatically on login via XDG autostart
- Zero-dependency install through a standard apt repository

## Requirements

- Debian/Ubuntu-based Linux distribution
- Python 3.10 or newer (pulled in automatically as a dependency)

---

## Install

Add the Tclippy apt repository and install the package:

```bash
echo "deb [trusted=yes] https://fortb164.github.io/Tclippy stable main" | sudo tee /etc/apt/sources.list.d/tclippy.list
sudo apt update
sudo apt install tclippy
```

Tclippy will start automatically the next time you log in. To start it immediately without logging out:

```bash
tclippy &
```

---

## Usage

Press **Ctrl + Super + V** (Super is the Windows/Command key) to open the clipboard history selector. Click or keyboard-navigate to any entry to copy it back to your clipboard. Press **Backspace** to close the selector without selecting anything.

---

## Update

```bash
sudo apt update
sudo apt upgrade tclippy
```

---

## Remove

Remove the package but keep configuration:

```bash
sudo apt remove tclippy
```

Fully remove the package and all configuration files:

```bash
sudo apt purge tclippy
sudo apt autoremove
```

Also remove the apt repository:

```bash
sudo rm /etc/apt/sources.list.d/tclippy.list
```

---

## Configuration

Settings are stored in `/usr/lib/tclippy/src/utils/userSettings.json`. You can edit this file to change the history size or hotkeys:

```json
{
  "maxHistorySize": 100,
  "shortcuts": {
    "globalHotkey": "<ctrl>+<cmd>+v",
    "closeSelector": "Backspace"
  }
}
```

Restart Tclippy after making changes.
