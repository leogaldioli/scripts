[Português](README.md) · **English**

# scripts

Google Chrome automation scripts for macOS via AppleScript, triggered by global hotkeys with [skhd](https://github.com/koekeishiya/skhd).

## Scripts

| Script | Hotkey | What it does |
|---|---|---|
| `chrome-focus-meet.applescript` | ⌃⌥⌘⇧M | Scans Chrome's windows/tabs and brings the Google Meet tab (`meet.google.com`) into focus: activates the tab, raises its window to the front, and focuses Chrome. Does nothing if no such tab exists. |
| `chrome-focus-calendar.applescript` | ⌃⌥⌘⇧C | Same behavior, for the Google Calendar tab (`calendar.google.com`). |
| `chrome-split-side-by-side.applescript` | ⌃⌥⌘↓ | Opens ONE new Chrome window and snaps it to the right half of the screen. Does NOT move any other window (whatever was focused stays where it is). |
| `chrome-detach-tab-right.applescript` | ⌃⌥⌘→ | "Detaches" the active tab into a new window snapped to the right. Since AppleScript can't move a tab while preserving its state, it reopens the active tab's URL in a new window and closes the original (visually identical to dragging the tab out; loses that tab's history/scroll). If the window has only one tab, it just snaps that window to the right. |

## How it works

**Focus scripts (meet/calendar):** iterate over Chrome's `windows` and `tabs` looking for the target URL. When found, they set `active tab index` to activate the tab, use `set index ... to 1` to raise the window to the front, and call `activate` to focus Chrome.

**Window scripts (split-side-by-side and detach-tab-right):** use `make new window` to create or reorganize windows, then snap by calling Rectangle's URL scheme (`open 'rectangle://execute-action?name=right-half'`), which acts on whichever window is focused at that moment.

## Dependencies

- macOS + Google Chrome
- [skhd](https://github.com/koekeishiya/skhd) for the global hotkeys — `brew install koekeishiya/formulae/skhd`
- [Rectangle](https://rectangleapp.com/) for the snap via the `rectangle://execute-action` URL scheme — only required for `chrome-split-side-by-side.applescript` and `chrome-detach-tab-right.applescript`

## Installation

1. Copy the `.applescript` files to `~/Library/Scripts/` (or another folder; adjust the paths in `skhdrc.example` accordingly)
2. Install skhd and start the service:
   ```sh
   brew install koekeishiya/formulae/skhd
   skhd --start-service
   ```
3. Copy the lines from `skhdrc.example` into `~/.config/skhd/skhdrc`
4. Grant permissions in **System Settings → Privacy & Security**:
   - **Accessibility** for `/opt/homebrew/bin/skhd`
   - **Automation**: skhd → Google Chrome (macOS prompts automatically the first time a hotkey fires)
5. Install [Rectangle](https://rectangleapp.com/) (required for the two snap scripts)

## Gotchas

- **The window scripts take ~1.5 s.** The snap acts on the focused window — if you click another window mid-run, focus shifts and the snap misses its target. Press the hotkey and wait ~1 s without clicking anything.
- **Rectangle action names in skhd use kebab-case** (`right-half`, `left-half`). Hex keycodes must be uppercase in skhd — that's why the `down` and `right` keys are referenced by name instead of hex codes.
