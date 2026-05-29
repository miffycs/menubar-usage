#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$BASH_SOURCE")/.."
rm -rf build dist
uv sync --group build
uv run python3 setup_app.py py2app
if [[ -d dist/main.app && ! -d dist/token-usage.app ]]; then
  mv dist/main.app dist/token-usage.app
fi
echo "Built: dist/token-usage.app"
