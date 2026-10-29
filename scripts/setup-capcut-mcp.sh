#!/usr/bin/env bash
# Installs the open-source VectCutAPI (CapCutAPI) MCP server so Claude Code
# can build CapCut drafts. Run this on the computer where CapCut is installed.
set -euo pipefail

DIR="${CAPCUT_MCP_DIR:-$HOME/VectCutAPI}"

command -v python3 >/dev/null || { echo "Python 3.10+ is required"; exit 1; }
command -v ffmpeg  >/dev/null || { echo "FFmpeg is required (brew install ffmpeg / apt install ffmpeg)"; exit 1; }

if [ ! -d "$DIR" ]; then
  git clone https://github.com/sun-guannan/VectCutAPI.git "$DIR"
fi

cd "$DIR"
python3 -m venv venv-capcut
./venv-capcut/bin/pip install -r requirements.txt -r requirements-mcp.txt
[ -f config.json ] || cp config.json.example config.json

echo
echo "Installed to $DIR"
echo "Add this to your shell profile (~/.zshrc or ~/.bashrc):"
echo "  export CAPCUT_MCP_DIR=\"$DIR\""
echo "Then open Claude Code in this repo and run /mcp to confirm 'capcut' is connected."
