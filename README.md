# LLM-CLI RC Context Menu

A Windows context menu integration for popular LLM command-line tools. Right-click on any folder to quickly launch your favorite AI assistants.

![LLM-CLI RC Installer](llm-cli-rc.png)

![Windows](https://img.shields.io/badge/platform-Windows-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## Features

- **One-click access** to multiple LLM CLIs from Windows Explorer
- **Supported tools:**
  - [Claude Code](https://github.com/anthropics/claude-code) - Anthropic's CLI for Claude
  - [Gemini CLI](https://github.com/google-gemini/gemini-cli) - Google's Gemini CLI
  - [Qwen](https://github.com/QwenLM/Qwen) - Alibaba's Qwen CLI
  - [Droid](https://factory.ai/) - Droid by Factory
  - [Opencode](https://github.com/anomalyco/opencode) - Open source AI coding assistant
- **Windows Terminal integration** - Opens in a new terminal tab
- **Custom icons** for each tool
- **Interactive installer** with configuration options

## Requirements

- Windows 10/11
- [Windows Terminal](https://aka.ms/terminal) installed
- The CLI tools you want to use must be installed and available in PATH

> **⚠️ Important:** This project **only installs the context menu integration**. It does **not** install the CLI tools themselves. You must install each CLI tool separately following their official documentation before using this menu.

## Installation

### Step 1: Install the CLI Tools

Before installing the context menu, make sure you have installed the CLI tools you want to use:

- **[Claude Code](https://github.com/anthropics/claude-code)** - Follow installation instructions in their repository
- **[Gemini CLI](https://github.com/google-gemini/gemini-cli)** - Check their documentation for setup
- **[Qwen](https://github.com/QwenLM/Qwen)** - See their official installation guide
- **[Droid](https://factory.ai/)** - Visit their website for installation steps
- **[Opencode](https://github.com/anomalyco/opencode)** - Follow their repository instructions

Ensure the CLI tools are available in your system PATH by testing them in a terminal (e.g., `claude`, `gemini`, `qwen`, `droid`, `opencode`).

### Step 2: Install the Context Menu

1. Clone or download this repository
2. Run `install.bat`
3. Follow the interactive prompts

### Installation Options

During installation, you'll be asked to select which **context menu entries** to add:

1. **[Claude Code](https://github.com/anthropics/claude-code)** - Adds two menu options:
   - **Claude Code** - Safe mode with permission prompts
   - **Claude Code (Yolo)** - Skips all permission prompts (use with caution)
2. **[Gemini CLI](https://github.com/google-gemini/gemini-cli)** - Google's Gemini CLI
3. **[Qwen](https://github.com/QwenLM/Qwen)** - Alibaba's Qwen CLI
4. **[Droid](https://factory.ai/)** - AI coding assistant
5. **[Opencode](https://github.com/anomalyco/opencode)** - Open source AI coding assistant

You can select any combination of tools - only the selected ones will appear in the context menu.

**Remember:** Install the actual CLI tools first by visiting their respective documentation pages (linked above).

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

This context menu installer does **not** install the CLI tools themselves. If you get a "command not found" error:

- Install the CLI tool by following its official documentation (see Installation section)
- Ensure the CLI tool is available in your system PATH
- Test by running the CLI command directly in a terminal first (e.g., `claude --version`)

## License

MIT License - Feel free to modify and distribute.

## Contributing

Contributions are welcome! Feel free to:

- Add support for more LLM CLIs
- Improve the installer
- Add new features

---

**Note:** This tool is not affiliated with Anthropic, Google, Alibaba, or any other AI company. It's a community utility to improve developer workflow.

<a href="https://buymeacoffee.com/avenca.digital" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 50px !important;width: 207px !important;" ></a>
