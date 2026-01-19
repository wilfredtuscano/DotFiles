# DotFiles

Personal dotfiles configuration for zsh, nvim, and tmux with comprehensive development environment setup.

## Prerequisites

Install the following tools before running the install script:

**Core Tools:**
- **zsh** - Shell
- **fzf** - Fuzzy finder (0.65.0)
- **zoxide** - Smart cd replacement
- **tmux** - Terminal multiplexer
- **nvim** - Neovim editor (v0.10+)
- **bat** - Better cat (for fzf preview)
- **git** - Version control
- **jq** - JSON processor
- **curl** - HTTP client
- **pandoc** - Document converter

**Amazon Internal (Optional):**
- **mwinit** - Amazon authentication
- **brazil** - Amazon build system
- **cr** - Code review CLI
- **code-search** - Amazon code search tool

### macOS (Homebrew)
```bash
brew install zsh fzf zoxide tmux neovim bat git jq curl pandoc
```

### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install zsh fzf tmux neovim bat git jq curl pandoc
# Install zoxide separately
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
```

#### NOTE: Use git repo with PATH export if version `fzf` version lower than recommended
```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

## Installation

1. Clone this repository
2. Install prerequisites above
3. Run the install script:
```bash
./install.sh
```

## Post-Installation Setup

### Zsh Plugins
The first time you start zsh, zinit will automatically install all plugins including:
- Powerlevel10k theme
- Syntax highlighting
- Autosuggestions
- fzf-tab

## What gets configured

### Zsh
- Zinit plugin manager with auto-installation
- Powerlevel10k theme with custom configuration
- Enhanced completions and syntax highlighting
- fzf integration for fuzzy finding

### Tmux Plugin Manager & Catppuccin Theme
After installation, start tmux and install plugins:
```bash
tmux
# Press Ctrl-a + I to install plugins (including Catppuccin theme)
```

### Additional Tools
- **fzf**: Fuzzy finder with custom keybindings and preview
- **zoxide**: Smart directory navigation with frecency algorithm

## Machine-specific configuration

Create `~/.zshrc.local.pre` and `~/.zshrc.local.post` for machine-specific settings that won't be version controlled.
Use `zsh/.zshrc.local.template` as a reference.

## Key Features

- **Zero-setup development environment** - Everything installs automatically

