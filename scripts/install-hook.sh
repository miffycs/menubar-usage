#!/usr/bin/env bash
# Install the menubar-usage Claude Code statusLine hook.
# For users who only downloaded the .app and don't have the source:
#   bash <(curl -fsSL https://raw.githubusercontent.com/miffycs/menubar-usage/master/scripts/install-hook.sh)
#
# What it does:
#   1. Downloads usage_statusline.py to ~/.claude/usage-statusline.py
#   2. Points ~/.claude/settings.json statusLine at it
#   3. Backs up any pre-existing statusLine under settings.usage.previousStatusLine
set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/miffycs/menubar-usage/master"
CLAUDE_DIR="${HOME}/.claude"
HOOK_PATH="${CLAUDE_DIR}/usage-statusline.py"
SETTINGS_PATH="${CLAUDE_DIR}/settings.json"

mkdir -p "${CLAUDE_DIR}"

echo "↓ Downloading hook to ${HOOK_PATH}"
curl -fsSL "${REPO_RAW}/usage_statusline.py" -o "${HOOK_PATH}"
chmod +x "${HOOK_PATH}"

PYTHON_BIN="$(command -v python3 || echo /usr/bin/python3)"

echo "✎ Updating ${SETTINGS_PATH}"
HOOK_PATH="${HOOK_PATH}" SETTINGS_PATH="${SETTINGS_PATH}" PYTHON_BIN="${PYTHON_BIN}" \
"${PYTHON_BIN}" - <<'PY'
import json, os, shlex

settings_path = os.environ["SETTINGS_PATH"]
hook_path = os.environ["HOOK_PATH"]
python_bin = os.environ["PYTHON_BIN"]

data = {}
if os.path.exists(settings_path):
    with open(settings_path, encoding="utf-8") as f:
        data = json.load(f)
if not isinstance(data, dict):
    raise SystemExit(f"❌ {settings_path} is not a JSON object; please fix manually")

existing = data.get("statusLine")
if isinstance(existing, dict) and "usage-statusline" not in str(existing.get("command", "")):
    data.setdefault("usage", {})["previousStatusLine"] = existing
    print("ℹ Backed up existing statusLine to settings.usage.previousStatusLine")

command = f"{shlex.quote(python_bin)} {shlex.quote(hook_path)}"
data["statusLine"] = {"type": "command", "command": command}

with open(settings_path, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
    f.write("\n")
PY

echo
echo "✓ Done"
echo "→ Fully quit Claude Code (Cmd+Q) and reopen it,"
echo "  then click 'Refresh Now' in the menubar-usage window."
