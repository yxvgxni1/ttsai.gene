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
if command -v claude >/dev/null; then
  claude mcp add capcut -e PYTHONPATH="$DIR" -- "$DIR/venv-capcut/bin/python" "$DIR/mcp_server.py"
  echo "Registered 'capcut' with Claude Code. Run claude, then /mcp to confirm."
else
  echo "Claude Code not found. Install it, then run:"
  echo "  claude mcp add capcut -e PYTHONPATH=\"$DIR\" -- \"$DIR/venv-capcut/bin/python\" \"$DIR/mcp_server.py\""
fi
