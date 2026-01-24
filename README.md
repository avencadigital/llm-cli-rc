# LLM-CLI RC Context Menu

A Windows context menu integration for popular LLM command-line tools. Right-click on any folder to quickly launch your favorite AI assistants.

![Windows](https://img.shields.io/badge/platform-Windows-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## Features

- **One-click access** to multiple LLM CLIs from Windows Explorer
- **Supported tools:**
  - [Claude Code](https://github.com/anthropics/claude-code) - Anthropic's CLI for Claude
  - [Gemini CLI](https://github.com/google-gemini/gemini-cli) - Google's Gemini CLI
  - [Qwen](https://github.com/QwenLM/Qwen) - Alibaba's Qwen CLI
  - [Droid]([https://github.com/plandex-ai/plandex](https://factory.ai/)) - Droid by Factory
  - [Opencode](https://github.com/opencode-ai/opencode) - Open source AI coding assistant
- **Windows Terminal integration** - Opens in a new terminal tab
- **Custom icons** for each tool
- **Interactive installer** with configuration options

## Requirements

- Windows 10/11
- [Windows Terminal](https://aka.ms/terminal) installed
- The CLI tools you want to use must be installed and available in PATH

## Installation

1. Clone or download this repository
2. Run `install.bat`
3. Follow the interactive prompts

### Installation Options

During installation, you'll be asked to select which CLI tools to install:

1. **Claude Code** - Installs two menu options:
   - **Claude Code** - Safe mode with permission prompts
   - **Claude Code (Yolo)** - Skips all permission prompts (use with caution)
2. **Gemini CLI** - Google's Gemini CLI
3. **Qwen** - Alibaba's Qwen CLI
4. **Droid** - AI coding assistant
5. **Opencode** - Open source AI coding assistant

You can install any combination of tools - only the selected ones will appear in the context menu.

## Usage

After installation:

1. Right-click on any **folder** in Windows Explorer
2. Select **"LLM-CLI RC"** from the context menu
3. Choose your preferred AI assistant

You can also right-click on an **empty area** inside any folder to get the same menu.

## Uninstallation

Run `uninstall.bat` to:
- Remove all registry entries
- Delete the `%USERPROFILE%\.llm-cli` folder and its contents

**Note:** Administrator privileges are required for uninstallation.

## File Structure

```
.
├── install.bat           # Interactive installer script
├── uninstall.bat         # Uninstaller script
├── assets/               # Icon files
│   ├── cli.ico           # Main menu icon
│   ├── claude.ico        # Claude Code icon
│   ├── gemini.ico        # Gemini CLI icon
│   ├── qwen.ico          # Qwen icon
│   ├── droid.ico         # Droid icon
│   └── opencode.ico      # Opencode icon
├── registry/             # Registry files
│   └── LLM_CLI_REMOVER.reg
├── legacy/               # Deprecated files
└── README.md             # This file
```

## Configuration

The installer creates files in `%USERPROFILE%\.llm-cli\`:
- `assets/` - Copied icon files

**Note:** Administrator privileges are required for installation.

## Security Note

The **Claude Code (Yolo)** option uses `--dangerously-skip-permissions` which bypasses all permission prompts. While convenient, this means Claude can:
- Read/write files without asking
- Execute commands without confirmation
- Make changes to your system

**Only use Yolo mode in trusted environments and projects you control.**

## Troubleshooting

### Context menu not appearing
- Try restarting Windows Explorer or logging out/in
- Check if registry entries exist in `HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI`

### "wt.exe not found"
- Install [Windows Terminal](https://aka.ms/terminal) from the Microsoft Store

### CLI not found when launching
- Ensure the CLI tool is installed and available in your system PATH
- Try running the CLI command directly in a terminal first

## License

MIT License - Feel free to modify and distribute.

## Contributing

Contributions are welcome! Feel free to:
- Add support for more LLM CLIs
- Improve the installer
- Add new features

---

**Note:** This tool is not affiliated with Anthropic, Google, Alibaba, or any other AI company. It's a community utility to improve developer workflow.
