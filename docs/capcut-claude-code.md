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
1. Clone this repo on your computer and run:
   ```bash
   ./scripts/setup-capcut-mcp.sh
   ```
2. Add the line it prints to your shell profile, e.g.
   `export CAPCUT_MCP_DIR="$HOME/VectCutAPI"`, then restart your terminal.
3. Start Claude Code in this repo. The `.mcp.json` here registers the `capcut`
   server; approve it when asked, then run `/mcp` to check it's connected.

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
