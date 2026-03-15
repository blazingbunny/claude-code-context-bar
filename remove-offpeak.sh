#!/bin/bash
# Removes the March 2026 off-peak promotion additions:
#   - offpeak-timer.sh
#   - promo block in context-bar.sh
#   - this script itself

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONTEXT_BAR="$SCRIPT_DIR/context-bar.sh"
OFFPEAK_TIMER="$SCRIPT_DIR/offpeak-timer.sh"

# Remove offpeak-timer.sh
if [[ -f "$OFFPEAK_TIMER" ]]; then
    rm "$OFFPEAK_TIMER"
    echo "Removed offpeak-timer.sh"
else
    echo "offpeak-timer.sh not found — skipping"
fi

# Patch context-bar.sh: remove promo block and restore output line
if [[ -f "$CONTEXT_BAR" ]]; then
    python3 - "$CONTEXT_BAR" <<'PYEOF'
import sys, re

path = sys.argv[1]
with open(path) as f:
    content = f.read()

# Remove promo block (from comment line to closing fi + blank line)
content = re.sub(
    r'\n# Promotion window indicator.*?^fi\n\n',
    '\n',
    content,
    flags=re.DOTALL | re.MULTILINE
)

# Restore original output line
content = content.replace(
    'output+="${promo_status} | ${ctx}${C_RESET}"',
    'output+=" | ${ctx}${C_RESET}"'
)

with open(path, 'w') as f:
    f.write(content)

print("Patched context-bar.sh")
PYEOF
else
    echo "context-bar.sh not found — skipping"
fi

# Remove this script
rm -- "$0"
echo "Done — all promotion additions removed"
