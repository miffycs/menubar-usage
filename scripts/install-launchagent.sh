#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
VENV_PYTHON="${PROJECT_DIR}/.venv/bin/python3"
PLIST_NAME="io.miffy.menubar-usage.plist"
TARGET_PLIST="${HOME}/Library/LaunchAgents/${PLIST_NAME}"

if [ ! -f "$VENV_PYTHON" ]; then
    echo "Error: Python venv not found at $VENV_PYTHON"
    exit 1
fi

mkdir -p "${HOME}/Library/Logs/usage"

echo "Generating plist..."
sed -e "s|__PROJECT_DIR__|${PROJECT_DIR}|g" \
    -e "s|__VENV_PYTHON__|${VENV_PYTHON}|g" \
    -e "s|__HOME__|${HOME}|g" \
    "${SCRIPT_DIR}/${PLIST_NAME}" > "${TARGET_PLIST}"

echo "Loading LaunchAgent..."
launchctl unload "${TARGET_PLIST}" 2>/dev/null || true
launchctl load "${TARGET_PLIST}"

echo "✓ Installed. Will auto-start on next login. To start now: launchctl start io.miffy.menubar-usage"
