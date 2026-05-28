# menubar-usage

English · [繁體中文](README.zh-TW.md)

A macOS menu bar app that shows live Claude Code and Codex token usage and estimated cost — by reading local session logs only. No API calls to Anthropic or OpenAI.

## Features

- Menu bar icon with live 5-hour and 7-day quota percentages
- Click for detailed breakdowns (HTML popover with 7 themes)
- Terminal view (`--tui`) with colored progress bars
- Optional Claude Code statusLine hook (off by default; safe to skip if you already have one)
- Reads only local files — never the network for usage data

## Install

### From source

```bash
git clone https://github.com/miffycs/menubar-usage.git
cd menubar-usage
python3 -m venv .venv && source .venv/bin/activate
pip install -e .
python3 main.py
```

### Pre-built .app

Download `menubar-usage.app.zip` from the [Releases page](https://github.com/miffycs/menubar-usage/releases) once releases are cut, unzip, and drop into `/Applications`.

### Auto-start at login (source install only)

```bash
./scripts/install-launchagent.sh    # install
./scripts/uninstall-launchagent.sh  # remove
```

## Usage

```bash
python3 main.py                  # menu bar mode (default)
python3 main.py --tui            # terminal TUI mode
python3 main.py --mock           # preview with fake data
python3 main.py --setup          # install Claude Code statusLine hook (opt-in)
python3 main.py --unsetup        # remove the hook
USAGE_DEBUG=1 python3 main.py    # surface swallowed exceptions
```

## Statusline (optional)

The statusLine hook is **off by default**. It only modifies `~/.claude/settings.json` if you explicitly run `--setup` or click the in-app button. If you already have your own statusLine, skip this — the menu bar app works without it.

## Development

```bash
uv sync --frozen --group dev
uv run ruff check
uv run mypy .
uv run pytest -v
```

See [CONTRIBUTING.md](CONTRIBUTING.md) for the pre-PR checklist.

## License

[AGPL-3.0-only](LICENSE).
