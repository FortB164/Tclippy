# Tclippy

A lightweight clipboard history manager for Linux — fast, persistent, and designed to stay out of your way until you need it.

---

## Why Tclippy?

Most clipboard managers become cluttered, slow, or noisy over time. Tclippy stays minimal: no tray icons, no startup popups, no notification spam. It preloads its popup so it opens instantly, keeps your history across reboots, and supports keyboard-first workflows — plus multiple named clipboards for separating work, personal, and project-specific content.

---

## What's New in v1.0.6

- **Fixed:** Deleted entries no longer reappear after a new copy operation.
- **Code quality:** UI split into focused modules (`dialogs.py`, `list_item.py`, `selector.py`) with centralized dark-theme dialog styling; settings keybinds now data-driven; `ClipboardEntry` uses `__slots__` to cut per-instance memory.
- **Performance:** Incremental list updates and widget reuse during search cut memory churn by ~73% on large histories (191 MiB vs 706 MiB in local benchmarks). Redundant list rebuilds are now skipped.
- **Testing:** 131 passing tests across all modules, including new test files for dialogs and list items, plus a configurable memory benchmark (`quick` / `full` / `stress` modes).
- **UI:** Small version indicator added to the settings menu.

---

## Features

- **Instant global popup** — Press `Ctrl + Super + V` and your clipboard appears immediately. The selector is preloaded at startup, eliminating visible lag.
- **Smart duplicate handling** — Repeated copies of identical content are fingerprinted and deduplicated instead of stacking up.
- **Multiple named clipboard boards** — Separate histories for work, personal, projects, or temporary use. Each board can have its own history limit and persist automatically.
- **Persistent history** — Entries survive application restarts, desktop logouts, and full reboots. Images are serialized and restored automatically.
- **Starred items** — Pin entries that survive reboots, restarts, history clears, and auto-removal.
- **Rich content support** — Plain text, rich text, images (displayed inline), files, folders, and URLs (with an "Open in browser" action).
- **In-place text editing** — Edit any text entry before re-pasting.
- **Live-updating list** — New clipboard items appear at the top of the open selector in place, without flicker or rebuilds.
- **Keyboard-first workflow** — Full navigation and actions from the keyboard; all shortcuts remappable inside the UI.
- **Draggable, frameless dark UI** — Move the popup anywhere; its position is remembered between sessions.
- **Silent background operation** — No tray icons, splash screens, or notifications. Starts with your session and stays invisible until needed.
- **Linux/X11 stability** — Explicit X11 threading initialization and Qt signal bridging avoid the crashes common when combining global hotkeys with Qt GUIs.
- **Ordered hotkey detection** — Enforces key order (Ctrl before Super + V by default) to prevent accidental triggers.

---

## Usage

### Opening the selector

Press `Ctrl + Super + V`. The history popup appears instantly. Press `Backspace` to close it without selecting anything.

### Keyboard shortcuts

| Key | Action |
| --- | --- |
| ↑ / ↓ | Move between entries |
| Enter | Select highlighted entry |
| Backspace | Close selector |
| Delete | Delete selected entry |
| Ctrl + A | Select all entries |
| Ctrl + E | Edit selected text entry |
| Ctrl + S | Star/unstar selected entry |

All shortcuts can be remapped live from the Settings dialog.

### Editing and starring

- **Edit:** Press `Ctrl + E` on any non-image entry (or click the Edit button).
- **Star/pin:** Click the ★ icon or press `Ctrl + S`. Starred entries persist across reboots, restarts, and history clears, and are never auto-removed.

### Multiple boards

Switch between named clipboards instantly from the UI. Boards can have different history limits, persist automatically, and be deleted independently. Moving items between boards is not currently supported.

### Configuration

Settings live at `~/.config/tclippy/userSettings.json`, including history size, selector position, and keybindings. Invalid values safely fall back to defaults, and older configs are migrated automatically on first launch.

---

## Installation

**Requirements:** Debian/Ubuntu-based Linux, Python 3.10+ (installed automatically as a dependency).

### Option 1 — apt repository (recommended)

```bash
echo "deb [trusted=yes] https://fortb164.github.io/Tclippy stable main" | sudo tee /etc/apt/sources.list.d/tclippy.list
sudo apt update
sudo apt install tclippy
```

### Option 2 — standalone .deb

```bash
sudo dpkg -i tclippy_1.0.4_all.deb
sudo apt -f install
```

Tclippy starts automatically on next login, or launch it immediately with:

```bash
tclippy &
```

### Updating

```bash
sudo apt update
sudo apt upgrade tclippy
```

### Removing

```bash
sudo apt remove tclippy          # keep config
sudo apt purge tclippy           # remove config too
sudo apt autoremove
sudo rm /etc/apt/sources.list.d/tclippy.list   # remove repo
```
