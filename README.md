# context-bar
As mentioned on my social media posts:
[Facebook post](https://www.facebook.com/adrian.delrosario.39/posts/pfbid02vdbkM73QQz7H3rYRAkcCKMKsKBB4jKdygSQPJ1qAb7HrmdQ3XMB882QSPxmpnd15l) — sharing this with the Claude Code community

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

## Compatibility

| Platform | Status | Notes |
|----------|--------|-------|
| **Linux** | Full support | Primary target |
| **macOS** | Full support | `stat` fallback already handled |
| **Windows** | Via WSL only | Run inside WSL — Claude Code on Windows uses WSL anyway |

Dependencies: `bash`, `git`, `jq`, `python3` (for `remove-offpeak.sh`). All standard on Linux/macOS.

## See Also

- [ykdojo/claude-code-tips](https://github.com/ykdojo/claude-code-tips/tree/main) — inspiration for the status line customization (Tip 0)
- [Claude March 2026 Usage Promotion](https://support.claude.com/en/articles/14063676-claude-march-2026-usage-promotion) — the promotion these scripts track

