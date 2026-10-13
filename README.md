# DotFiles

Personal dotfiles configuration for zsh, nvim, and tmux with comprehensive development environment setup.

## Prerequisites

`Brewfile` is the source of truth; this list is the reasoning behind it.

**Required:**
- **zsh** shell
- **neovim** v0.12+. Not 0.11: nvim-treesitter's `main` branch requires 0.12 or later, and
  `master` does not support 0.12 at all. See the Treesitter notes in `CLAUDE.md`.
- **tree-sitter-cli** 0.26.1+, via a package manager, not npm. The treesitter rewrite compiles
  parsers through `tree-sitter build` rather than calling cc, so without this every parser
  install fails with ENOENT.
- **ripgrep** required by telescope `live_grep`
- **fd** required by telescope `find_files`
- **node / npm** JS and TS language servers and formatters
- **git**, **curl**

**Expected by the config:**
- **fzf** (0.65.0+) history search and fzf-tab
- **zoxide** smart cd
- **tmux** terminal multiplexer. TPM installs itself from `tmux.conf`
- **bat** fzf previews
- **eza** modern ls, aliased in `.zshrc`
- **stylua** Lua formatter, run on save by conform
- **lazygit** git TUI, opened from nvim with `<leader>gg`
- **jq**, **tldr**

**Optional:**
- A JDK, if you want Java or Kotlin. Temurin is what this machine uses; brew's `openjdk` is
  deliberately absent from the Brewfile so it does not install a parallel set.
- A Nerd Font. `font-caskaydia-cove-nerd-font` is in the Brewfile; set your terminal to the
  **Mono** variant, `CaskaydiaCoveNFM`, since the non-Mono build has double-width glyphs that
  break column alignment.

### Install the prerequisites (macOS)
```bash
# everything above, from the manifest
brew bundle --file=Brewfile

# or, to see what is missing without changing anything
brew bundle check --file=Brewfile
```

Note that `brew bundle install` also upgrades anything outdated as a side effect, so on an
established machine prefer `check` and upgrade deliberately.

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
| `<C-/>` | n, t | Toggle floating terminal (toggleterm) |

Inside the floating terminal, `<Esc><Esc>` (twice, not once) leaves insert mode so you can
scroll, yank and search the scrollback; `i` or `a` returns to the prompt. A single `<Esc>` is
left alone deliberately: it is fzf's cancel key inside the shell, which Ctrl-R history and
fzf-tab both rely on. Hiding the terminal keeps the shell running; `exit` closes it for real.

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
| `<leader>gg` | n | LazyGit, scoped to the current file's repo |

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
| `<leader>mdt` | n | Toggle rendered markdown |
| `<leader>mds` | n | Markdown side by side, raw and rendered |

### Selection / Treesitter — `<leader>s`

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>ss` | n, x | Select the smallest node under the cursor |
| `<leader>si` | n, x | Grow to the next enclosing node |
| `<leader>sd` | n, x | Shrink back one step |

Implemented locally in `nvim/lua/config/ts-selection.lua`, not by a plugin: nvim-treesitter's
`main` rewrite removed its incremental_selection module with no replacement. Any edit to the
buffer invalidates the selection stack, so start again with `<leader>ss`.

### LeetCode — `<leader>L`

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>Lc` | n | Open LeetCode |
| `<leader>Ll` | n | List problems |
| `<leader>Lt` | n | Test solution |
| `<leader>Ls` | n | Submit solution |
| `<leader>Lr` | n | Run solution |
| `<leader>Li` | n | Problem info |
| `<leader>Ld` | n | Toggle the problem description pane |
| `<leader>Ln` | n | Start the next numbered solution |

Solutions are written to `~/hq/growth/leetcode/problems/<3-digit-id>-<slug>/NN-<slug>.kt`.
`<leader>Ln` saves the current attempt and opens the next number with the same contents, so
earlier approaches are kept rather than overwritten. **Do not rename a solution file**: the
plugin finds the latest attempt by matching the exact `NN-<slug>.<ext>` shape, so a renamed
file restarts the counter and the next attempt overwrites the previous one.
