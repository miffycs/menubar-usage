# menubar-usage

[English](README.md) · 繁體中文

一款 macOS menubar 小工具,即時顯示 Claude Code 與 Codex 的 token 用量與預估費用 — 純讀本機 session log,完全不打 Anthropic 或 OpenAI 的 API。

## 功能

- menubar 圖示顯示即時 5 小時與 7 天額度百分比
- 點擊看詳細拆解(HTML popover,七種主題可選)
- 終端機介面(`--tui`)含彩色進度條
- 可選的 Claude Code statusLine hook(預設關閉;已有自訂 statusLine 可放心跳過)
- 只讀本機檔案 — 用量資料絕不走網路

## 安裝

### 從原始碼

```bash
git clone https://github.com/miffycs/menubar-usage.git
cd menubar-usage
python3 -m venv .venv && source .venv/bin/activate
pip install -e .
python3 main.py
```

### 預先打包的 .app

從 [Releases 頁面](https://github.com/miffycs/menubar-usage/releases) 下載 `menubar-usage.app.zip`(待發佈),解壓後拖到 `/Applications`。

### 開機自動啟動(僅限原始碼安裝)

```bash
./scripts/install-launchagent.sh    # 安裝
./scripts/uninstall-launchagent.sh  # 移除
```

## 使用

```bash
python3 main.py                  # menubar 模式(預設)
python3 main.py --tui            # 終端機 TUI 模式
python3 main.py --mock           # 用假資料預覽
python3 main.py --setup          # 安裝 Claude Code statusLine hook(可選)
python3 main.py --unsetup        # 移除 hook
USAGE_DEBUG=1 python3 main.py    # 顯示被忽略的例外
```

## Statusline(可選)

statusLine hook **預設關閉**。只有當你明確執行 `--setup` 或在 App 內按下對應按鈕時,才會修改 `~/.claude/settings.json`。如果你已有自己的 statusLine,跳過即可 — menubar 本體完全不受影響。

## 開發

```bash
uv sync --frozen --group dev
uv run ruff check
uv run mypy .
uv run pytest -v
```

PR 前置檢查清單見 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 授權

[AGPL-3.0-only](LICENSE)。
