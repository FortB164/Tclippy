# Tclippy

Tclippy is a lightweight clipboard history manager for Linux. It runs silently in the background, tracks everything you copy, and lets you quickly browse and re-paste any previous entry using a global hotkey.

## Features

- Stores up to 100 clipboard entries per clipboard (configurable)
- Supports text, images, files, and links
- Global hotkey popup selector (`Ctrl + Super + V` by default)
- Starts automatically on login via XDG autostart
- Zero-dependency install through a standard apt repository
- Multiple named clipboards with optional boot persistence
- Favourite any entry to make it persist across reboots

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

### Opening and closing

Press **Ctrl + Super + V** (Super is the Windows/Command key) to open the clipboard history selector. Press **Backspace** to close it without selecting anything.

### Navigating and selecting

| Key | Action |
|-----|--------|
| **↑ / ↓** | Move between entries |
| **Enter** | Select the highlighted entry and close the GUI |
| **Backspace** | Close without selecting |

### Deleting entries

- Navigate to an entry and press **Delete** to remove it.
- Press **Ctrl + A** to select all entries, then **Delete** to clear the entire history.

### Supported content types

Tclippy tracks text, images, files, and links:

- **Images** — displayed inline in the history list.
- **Files** — shown with their file path.
- **Links** — shown with a browser icon on the left; click it to open the link in your default browser.
- **Text / other** — shown as plain text.

### Editing entries

Non-image entries have an **Edit** button. Click it to modify the stored text directly in the GUI.

### Favouriting entries

Click the **★ star** icon beside any entry to favourite it. Favourited entries are boot-persistent — they survive reboots and are never automatically evicted from history.

### Multiple clipboards

You can create and switch between several named clipboards to keep different sets of content separate. Each clipboard can have persistence toggled on or off independently. Moving items between clipboards is not currently supported.

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
