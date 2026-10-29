# Connect Claude Code to CapCut

CapCut has no official API. This setup uses the open-source
[VectCutAPI](https://github.com/sun-guannan/VectCutAPI) MCP server, which writes
CapCut **draft projects** (video, audio, text, captions, effects, keyframes).
You then open the draft in CapCut and export it there.

Everything runs on **your own computer** (the one with CapCut installed).

## Requirements
- CapCut desktop (International) or Jianying
- Python 3.10+, FFmpeg, git
- Claude Code CLI or desktop app

## Setup

### Mac / Linux
Run `./scripts/setup-capcut-mcp.sh` from this repo, then start `claude` here and run `/mcp`.

### Windows (Command Prompt)
```
winget install Python.Python.3.12
winget install Gyan.FFmpeg
```
Open a new terminal, then:
```
cd %USERPROFILE%
git clone https://github.com/sun-guannan/VectCutAPI.git
cd VectCutAPI
python -m venv venv-capcut
venv-capcut\Scripts\pip install -r requirements.txt -r requirements-mcp.txt
copy config.json.example config.json
cd %USERPROFILE%\ttsai.gene
claude mcp add capcut -e PYTHONPATH=%USERPROFILE%\VectCutAPI -- %USERPROFILE%\VectCutAPI\venv-capcut\Scripts\python.exe %USERPROFILE%\VectCutAPI\mcp_server.py
```
Start `claude` in this repo and run `/mcp`; `capcut` should show 11 tools.

## Using it
Ask Claude things like:
> Create a 1080x1920 CapCut draft, add `product.mp4`, put the caption
> "50% off today only" at the top for the first 3 seconds, then save the draft.

Tools include `create_draft`, `add_video`, `add_audio`, `add_image`, `add_text`,
`add_subtitle`, `add_effect`, `add_video_keyframe`, `save_draft`, and more.

## Getting the draft into CapCut
`save_draft` creates a folder named `dfd_...` inside the VectCutAPI folder.
**Close CapCut**, copy that folder into CapCut's drafts directory, then reopen CapCut:
- macOS: `~/Movies/CapCut/User Data/Projects/com.lveditor.draft/`
- Windows: `%LOCALAPPDATA%\CapCut\User Data\Projects\com.lveditor.draft\`

(CapCut autosaves, so editing a draft while it's open can overwrite changes.)
Rendering/export is still done manually in CapCut.
