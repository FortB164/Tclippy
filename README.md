# Tclippy

Tclippy is a lightweight clipboard history manager for Linux that stays out of your way until you need it. 

Unlike traditional clipboard managers, Tclippy is designed around speed, persistence, and minimal friction:

* Instant popup selector with zero visible startup lag
* Multiple named clipboards
* Persistent starred items that survive reboots and clears
* Support for text, images, files, folders, and links
* Fully configurable shortcuts directly inside the app
* Frameless dark-themed UI designed for keyboard-first workflows
* Packaged as a standard Debian `.deb` package with automatic login startup

---

# What's New in v1.0.4

`build.deb_v1.0.4` is the fourth official Debian-packaged release of Tclippy.

This release builds on the earlier `build.deb_v1.0.1`, `v1.0.2`, and `v1.0.3` branches and introduces a major UI and configuration overhaul.

## Major additions in v1.0.4

### Completely redesigned UI

The selector popup has been rebuilt from the ground up with:

* A modern dark navy/deep-blue theme
* Live-updating history list with no flicker
* Rich clipboard item rendering
* Draggable popup positioning
* Persistent window placement between sessions
* Consistent themed dialogs and confirmation prompts

### Full in-app settings system

Tclippy no longer requires manual JSON editing for normal configuration.

A new Settings dialog now allows live configuration of:

* Keyboard shortcuts
* Clipboard boards
* Persistence settings
* History limits
* Popup positioning

All settings are stored automatically in:

```text
~/.config/tclippy/userSettings.json
```

### Multiple clipboard boards

Create separate clipboard environments such as:

* Work
* Personal
* Temporary
* Research

Each board has:

* Its own history
* Its own maximum size
* Optional full-board persistence
* Independent saved state

### Better clipboard type support

Tclippy now stores and restores:

* Text
* Images
* File paths
* Folder paths
* URLs

Clipboard entries are rendered intelligently:

```text
[Image] 1920x1080
[File] /home/user/Documents/report.pdf
```

URL entries also include an "Open in browser" action.

### Safer and more reliable daemon handling

Tclippy now prevents multiple daemon instances from launching simultaneously using a filesystem lock:

```text
~/.cache/tclippy/daemon.lock
```

If a second instance is launched accidentally, it exits safely with a clear message.

---

# What's New in v1.0.6

This release focuses on **code quality, test coverage, and memory optimization** to ensure Tclippy remains snappy and reliable even with large clipboard histories.

## Bug fixes

* **Fixed reappearing deleted entries**: Deleted clipboard entries no longer reappear after a new copy operation (root cause: selector's internal cache wasn't synced on delete)

## Code quality & refactoring

* **Modular UI architecture**: Split the monolithic `selector.py` (2203 → 1541 lines) into focused modules:
  - `dialogs.py` — Reusable dialog helpers (`TextEditDialog`, `prompt_text`, themed confirmation/message dialogs)
  - `list_item.py` — Clipboard list item widget with cached star icons and unified button styling
  - `selector.py` — Focused selector controller logic

* **Centralized dialog styling**: All dark-themed dialogs now inherit consistent styling from `dialogs.py`, reducing duplication

* **Data-driven keybind configuration**: Keybind input rows are now constructed from a simple list instead of verbose repeated code

* **Dataclass memory optimization**: Added `__slots__` to `ClipboardEntry` to reduce per-instance memory overhead

## Performance improvements

* **Incremental list updates**: New `prependHistoryItem()` and `removeHistoryItem()` paths bypass full list rebuild during live history updates, reducing memory allocation churn
* **Widget reuse during search**: Search filter now rescues and reuses existing `ClipboardListItem` widgets instead of allocating new ones every keystroke
* **Render-state short-circuit**: Skips redundant list rebuilds when search results haven't changed
* **Result**: ~73% memory reduction during add/remove churn on large histories (191 MiB vs 706 MiB in local benchmarks)

## Testing & benchmarking

* **Comprehensive test coverage**: 131 passing tests covering all modules with batch-level reporting (pass/fail per test class)
* **New test files**:
  - `test_dialogs.py` — Dialog helpers and themeing
  - `test_list_item.py` — List item widget and icon caching
  - Added `__slots__` coverage in `test_models.py`

* **Configurable memory benchmark**: `Test/benchmark_selector_memory.py` now accepts preset modes (`--mode quick|full|stress`) and configurable operation counts for repeatable regression gating:
  - Quick mode: 200 seed entries, 50 search iterations, 50 add/remove iterations
  - Full mode (default): 1000 seed entries, 300 search iterations, 200 add/remove iterations
  - Stress mode: 5000 seed entries, 1000 search iterations, 500 add/remove iterations

## UI refinements

* **Version number in settings**: Tiny version indicator in the settings menu (for internal reference)

---

# Features

## Instant global popup

Press:

```text
Ctrl + Super + V
```

and your entire clipboard appears instantly.

The selector widget is preloaded during startup, so the popup is already built before you press the hotkey. This eliminates the visible lag common in many clipboard managers.

## Smart duplicate handling

Every clipboard item is fingerprinted internally.

If you copy the same content repeatedly, Tclippy avoids duplicate clutter instead of endlessly stacking identical entries.

## Keyboard-first workflow

Everything can be controlled from the keyboard:

| Key       | Action                     |
| --------- | -------------------------- |
| ↑ / ↓     | Navigate entries           |
| Enter     | Select entry               |
| Backspace | Close selector             |
| Delete    | Delete selected entry      |
| Ctrl + A  | Select all entries         |
| Ctrl + E  | Edit selected text entry   |
| Ctrl + S  | Star/unstar selected entry |

All shortcuts are remappable directly inside the UI.

## Multiple named clipboard boards

Switch between separate clipboard histories instantly.

Example setups:

* Work clipboard
* Personal clipboard
* Project-specific clipboard
* Temporary clipboard

Each board can optionally persist all copied content automatically.

## Persistent clipboard history

Tclippy remembers clipboard entries across:

* Application restarts
* Desktop logouts
* Full system reboots

Images are serialized and restored automatically using Base64-backed persistence.

## Live updating history list

Clipboard updates appear immediately at the top of the selector while it is open.

The list updates in-place without tearing down and rebuilding the UI, keeping navigation smooth and flicker-free.

## Rich content support

Tclippy supports:

* Plain text
* Rich text
* Images
* Files
* Folders
* URLs

Images are displayed inline in the selector.

URLs automatically gain an "Open in browser" action.

## In-place text editing

Text entries can be edited directly before re-pasting.

Press:

```text
Ctrl + E
```

on any text entry to open the editor.

## Draggable popup window

The selector window can be dragged anywhere on screen.

Its position is remembered automatically between sessions.

## Silent background operation

Tclippy intentionally avoids:

* Tray icons
* Splash screens
* Startup popups
* Notification spam

It starts with your desktop session and remains invisible until needed.

## Built for Linux/X11 stability

Global hotkey listeners and Qt GUIs commonly conflict on Linux due to threading issues.

Tclippy explicitly initialises X11 threading support and bridges events through Qt signals to avoid instability and random crashes.

## Ordered hotkey detection

The global shortcut listener enforces key order.

By default:

```text
Ctrl must be pressed before Super + V
```

This avoids accidental triggers caused by reversed key combinations.

---

# Requirements

* Debian or Ubuntu-based Linux distribution
* Python 3.10 or newer

Python is installed automatically as a dependency.

---

# Installation

## Option 1 — Install from the apt repository (recommended)

Add the Tclippy repository:

```bash
echo "deb [trusted=yes] https://fortb164.github.io/Tclippy stable main" | sudo tee /etc/apt/sources.list.d/tclippy.list
```

Update package lists:

```bash
sudo apt update
```

Install Tclippy:

```bash
sudo apt install tclippy
```

## Option 2 — Install the standalone `.deb`

```bash
sudo dpkg -i tclippy_1.0.4_all.deb
sudo apt -f install
```

---

# Package layout

The Debian package installs Tclippy into:

```text
/usr/lib/tclippy/
```

Launcher script:

```text
/usr/bin/tclippy
```

Automatic startup entry:

```text
/etc/xdg/autostart/tclippy.desktop
```

---

# Starting Tclippy

Tclippy launches automatically the next time you log in.

To start it immediately:

```bash
tclippy &
```

---

# Using Tclippy

## Opening the selector

Press:

```text
Ctrl + Super + V
```

The clipboard history popup appears instantly.

Press:

```text
Backspace
```

to close it without selecting anything.

---

# Keyboard shortcuts

| Key       | Action                     |
| --------- | -------------------------- |
| ↑ / ↓     | Move between entries       |
| Enter     | Select highlighted entry   |
| Backspace | Close selector             |
| Delete    | Delete selected entry      |
| Ctrl + A  | Select all entries         |
| Ctrl + E  | Edit selected text entry   |
| Ctrl + S  | Star/unstar selected entry |

All shortcuts can be remapped live from inside the Settings dialog.

---

# Editing clipboard entries

Non-image entries can be edited directly inside the application.

Use:

```text
Ctrl + E
```

or click the Edit button beside an entry.

---

# Favouriting / pinning entries

Click the ★ star icon or press:

```text
Ctrl + S
```

Starred entries:

* Persist across reboots
* Persist across application restarts
* Survive history clears
* Are never auto-removed

---

# Multiple clipboard boards

Tclippy supports independent named clipboards.

Examples:

* Work
* Personal
* Temporary
* Research

Each board can:

* Have a different history limit
* Persist automatically
* Be deleted independently
* Be switched instantly from the UI

Moving items between boards is not currently supported.

---

# Configuration

Tclippy now uses an XDG-compliant configuration system.

Configuration file:

```text
~/.config/tclippy/userSettings.json
```

Example:

```json
{
  "maxHistorySize": 100,
  "selectorPosition": {
    "x": 500,
    "y": 250
  },
  "shortcuts": {
    "globalHotkey": "<ctrl>+<cmd>+v",
    "closeSelector": "Backspace",
    "editEntry": "<ctrl>+e",
    "toggleFavourite": "<ctrl>+s"
  }
}
```

## Automatic legacy migration

Older installations using:

```text
src/utils/userSettings.json
```

are automatically migrated to the new XDG config location on first launch.

## Safe settings validation

Every configuration field is validated during startup.

If invalid values are detected, Tclippy safely falls back to defaults instead of crashing.

---

# Updating Tclippy

```bash
sudo apt update
sudo apt upgrade tclippy
```

---

# Removing Tclippy

Remove the package while keeping configuration:

```bash
sudo apt remove tclippy
```

Fully remove Tclippy and configuration files:

```bash
sudo apt purge tclippy
sudo apt autoremove
```

Remove the repository:

```bash
sudo rm /etc/apt/sources.list.d/tclippy.list
```

---

# Internal architecture

## Clipboard monitoring

Clipboard changes are tracked using Qt clipboard signals:

```text
QClipboard.dataChanged
```

No polling loop is used.

## Persistent history model

Clipboard entries are serialized to disk using typed persistence models.

Supported entry kinds:

* text
* image
* files

Images are Base64-encoded automatically for reboot persistence.

## Preloaded selector widget

The popup selector is instantiated during daemon startup instead of on first use.

This allows near-instant popup response times.

## Atomic settings saves

Settings changes are written atomically to disk to avoid corruption during unexpected shutdowns.

---

# Why Tclippy?

Most clipboard managers eventually become noisy, cluttered, or slow.

Tclippy focuses on:

* Instant access
* Keyboard-driven workflows
* Clean history management
* Reliable persistence
* Minimal desktop interference
* Simple installation

No tray app micromanagement.
No terminal setup.
No manual daemon configuration.

Just install it and use it.
