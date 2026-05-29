#!/bin/bash
set -euo pipefail

PLIST_NAME="io.miffy.token-usage.plist"
TARGET_PLIST="${HOME}/Library/LaunchAgents/${PLIST_NAME}"

echo "Unloading LaunchAgent..."
launchctl unload "${TARGET_PLIST}" 2>/dev/null || true

echo "Removing files..."
rm -f "${TARGET_PLIST}"
rm -f "${HOME}/Library/Logs/usage/usage.log"
rm -f "${HOME}/Library/Logs/usage/usage.err.log"
rmdir "${HOME}/Library/Logs/usage" 2>/dev/null || true

echo "✓ Removed"
