# DotFiles

Personal dotfiles configuration for zsh, nvim, and tmux with comprehensive development environment setup.

## Prerequisites

Install the following tools before running the install script:

**Core Tools:**
- **zsh** - Shell
- **fzf** - Fuzzy finder (0.65.0+)
- **zoxide** - Smart cd replacement
- **tmux** - Terminal multiplexer
- **nvim** - Neovim editor (v0.11+)
- **node / npm** - Required for JS/TS/HTML/CSS LSP servers and formatters
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
brew install zsh fzf zoxide tmux neovim node bat git jq curl pandoc
```

### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install zsh fzf tmux neovim bat git jq curl pandoc nodejs npm
# Install zoxide separately
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
```

#### NOTE: Use git repo with PATH export if fzf version is lower than recommended
```bash
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

### Tmux Plugin Manager & Catppuccin Theme
After installation, start tmux and install plugins:
```bash
tmux
# Press Ctrl-a + I to install plugins (including Catppuccin theme)
```

### Neovim
On first launch, lazy.nvim will automatically install all plugins and Mason will install LSP servers, formatters and linters. This may take a minute.

## What gets configured

### Zsh
- Zinit plugin manager with auto-installation
- Powerlevel10k theme with custom configuration
- Enhanced completions and syntax highlighting
- fzf integration for fuzzy finding
- zoxide for smart directory navigation

### Tmux
- Catppuccin theme
- Prefix key: `Ctrl-a`
- vim-tmux-navigator for seamless pane/window navigation with Neovim

### Neovim

**Plugin manager:** lazy.nvim

**LSP servers (via Mason):** lua_ls, ts_ls, eslint, cssls, html, pyright, jdtls, kotlin_language_server, nginx_language_server

**Formatters (via conform.nvim):** prettier (JS/TS/CSS/HTML/JSON/YAML/Markdown), stylua (Lua), google-java-format (Java, AOSP style), ktlint (Kotlin), nginx-config-formatter

**Linters (via nvim-lint):** flake8 (Python), eslint_d (JS/TS)

**Colorscheme:** Catppuccin Mocha

### Additional Tools
- **fzf**: Fuzzy finder with custom keybindings and preview
- **zoxide**: Smart directory navigation with frecency algorithm

## Machine-specific configuration

Create `~/.zshrc.local.pre` and `~/.zshrc.local.post` for machine-specific settings that won't be version controlled.
Use `zsh/.zshrc.local.template` as a reference.

---

## Neovim Keybindings

Leader key: `<Space>`

### General

| Keys | Mode | Description |
|------|------|-------------|
| `<C-s>` | n, i, v | Save all files |

### LSP (active on buffers with an attached LSP server)

| Keys | Mode | Description |
|------|------|-------------|
| `gd` | n | Go to definition |
| `gD` | n | Go to declaration |
| `gR` | n | Show references (Telescope) |
| `gi` | n | Show implementations (Telescope) |
| `gt` | n | Show type definitions (Telescope) |
| `K` | n | Hover documentation |
| `[d` | n | Previous diagnostic |
| `]d` | n | Next diagnostic |
| `<leader>d` | n | Show line diagnostics (float) |
| `<leader>ca` | n, v | Code actions |
| `<leader>rn` | n | Rename symbol |
| `<leader>lr` | n | Restart LSP |

### Completion (insert mode)

| Keys | Description |
|------|-------------|
| `<C-j>` | Next completion item |
| `<C-k>` | Previous completion item |
| `<C-b>` | Scroll docs up |
| `<C-f>` | Scroll docs down |
| `<C-Space>` | Trigger completion |
| `<C-e>` | Close completion |
| `<CR>` | Confirm selection |

### Find — `<leader>f`

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>ff` | n | Find files in cwd |
| `<leader>fr` | n | Recent files |
| `<leader>fs` | n | Find string in cwd |
| `<leader>fc` | n | Find string under cursor |
| `<leader>ft` | n | Find todos |
| `<leader>fk` | n | Find keymaps |
| `<leader>fd` | n | File diagnostics |
| `<leader>fD` | n | Workspace diagnostics |

**Inside Telescope:**

| Keys | Description |
|------|-------------|
| `<C-j>` | Move selection down |
| `<C-k>` | Move selection up |
| `<C-q>` | Send selected to quickfix + open Trouble |

### Explorer — `<leader>e`

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>ee` | n | Focus file explorer |
| `<leader>ef` | n | Reveal current file in explorer |
| `<leader>ec` | n | Close explorer |
| `<leader>er` | n | Refresh explorer |
| `<leader>eb` | n | Show open buffers |
| `<leader>eg` | n | Show git status |

### Buffer — `<leader>b`

| Keys | Mode | Description |
|------|------|-------------|
| `<Tab>` | n | Next buffer |
| `<S-Tab>` | n | Previous buffer |
| `<leader>bd` | n | Delete current buffer |
| `<leader>bD` | n | Delete all buffers |
| `<leader>bp` | n | Pin/unpin buffer |

### Workspace / Session — `<leader>w`

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>wr` | n | Find and open session (picker) |
| `<leader>wR` | n | Restore last session |
| `<leader>ws` | n | Save session |

### Git Hunks — `<leader>h`

| Keys | Mode | Description |
|------|------|-------------|
| `]h` | n | Next hunk |
| `[h` | n | Previous hunk |
| `<leader>hs` | n, v | Stage hunk |
| `<leader>hr` | n, v | Reset hunk |
| `<leader>hS` | n | Stage buffer |
| `<leader>hR` | n | Reset buffer |
| `<leader>hu` | n | Undo stage hunk |
| `<leader>hp` | n | Preview hunk |
| `<leader>hb` | n | Blame line |
| `<leader>hB` | n | Toggle line blame |
| `<leader>hd` | n | Diff this |
| `<leader>hD` | n | Diff this against ~ |
| `ih` | o, x | Select hunk (text object) |

### Git Diff — `<leader>g`

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>gd` | n | Open Diffview |
| `<leader>gh` | n | File history (all commits) |
| `<leader>gH` | n | File history (current file) |
| `<leader>gc` | n | Close Diffview |
| `<leader>gm` | n | Compare with previous commit |
| `<leader>gv` | n | 3-way merge conflict view |

### Trouble — `<leader>t`

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>tw` | n | Workspace diagnostics |
| `<leader>td` | n | Document diagnostics |
| `<leader>tq` | n | Quickfix list |
| `<leader>tl` | n | Location list |
| `<leader>tt` | n | Todos |

### Todos

| Keys | Mode | Description |
|------|------|-------------|
| `]t` | n | Next todo |
| `[t` | n | Previous todo |

### Code — `<leader>c`

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>ca` | n, v | Code actions (also in LSP section) |
| `<leader>cl` | n | Trigger linting |

### Format — `<leader>m`

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>mp` | n, v | Format file or range |

### Selection / Treesitter — `<leader>s`

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>ss` | n | Start incremental selection |
| `<leader>si` | n | Expand to next node |
| `<leader>sd` | n | Shrink to previous node |

### LeetCode — `<leader>L`

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>Lc` | n | Open LeetCode |
| `<leader>Ll` | n | List problems |
| `<leader>Lt` | n | Test solution |
| `<leader>Ls` | n | Submit solution |
| `<leader>Lr` | n | Run solution |
| `<leader>Li` | n | Problem info |
