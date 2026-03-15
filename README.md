# context-bar

Customized Claude Code status line scripts. Inspired by [ykdojo/claude-code-tips](https://github.com/ykdojo/claude-code-tips/tree/main) — specifically Tip 0 on status line customization.

## Files

### `context-bar.sh`
The main status line script, configured in `~/.claude/settings.json`:

```json
"statusLine": {
  "type": "command",
  "command": "~/.claude/scripts/context-bar.sh"
}
```

Displays per Claude Code session:

- **Model** — active Claude model name
- **Directory** — current project folder
- **Git branch** — with uncommitted file count and upstream sync status
- **Context bar** — visual token usage progress bar with percentage of context window used
- **Last message** — truncated preview of your last prompt
- **Promotion indicator** — during March 13–27, 2026: shows `🚀 2x ON | Xh Xm left` (off-peak) or `⏳ 2x in Xh Xm` (peak)

Color theme is set at the top of the file (`COLOR="blue"`). Available themes: orange, blue, teal, green, lavender, rose, gold, slate, cyan, gray.

---

### `offpeak-timer.sh`
Standalone countdown timer for the [Claude March 2026 Usage Promotion](https://support.claude.com/en/articles/14063676-claude-march-2026-usage-promotion).

- **Off-peak (2x usage):** 2 PM–8 AM ET / 2 AM–8 PM Manila time
- **Peak (standard usage):** 8 AM–2 PM ET / 8 PM–2 AM Manila time
- Refreshes every 15 minutes
- Works on any timezone — converts to ET internally

```bash
~/.claude/scripts/offpeak-timer.sh
```

---

### `remove-offpeak.sh`
Cleanup script for after the promotion ends (March 27, 2026).

Removes:
- `offpeak-timer.sh`
- The promotion block from `context-bar.sh`
- Itself

```bash
~/.claude/scripts/remove-offpeak.sh
```

## Installation

The live copies used by Claude Code live in `~/.claude/scripts/`. This folder is for version control and reference.

To sync changes back:

```bash
cp context-bar.sh ~/.claude/scripts/context-bar.sh
```
