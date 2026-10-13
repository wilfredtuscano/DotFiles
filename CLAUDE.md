# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository managing configurations for three tools: Neovim, Tmux, and Zsh. The setup script creates symlinks from `~/.config/` to this repo.

## Setup & Installation

```bash
# Install all dotfiles (creates symlinks, backs up existing configs)
./install.sh
```

Symlinks created:
- `~/.zshrc` → `zsh/.zshrc`
- `~/.p10k.zsh` → `zsh/.p10k.zsh`
- `~/.config/tmux/tmux.conf` → `tmux/tmux.conf`
- `~/.config/nvim` → `nvim/`

Machine-local overrides (git-ignored): `~/.zshrc.local.pre` and `~/.zshrc.local.post`.

## Neovim Architecture

**Entry point**: `nvim/init.lua`, which bootstraps lazy.nvim, loads `config/` and `plugins/`.

**Structure**:
```
nvim/lua/
├── config/
│   ├── settings.lua   # Leader key (Space)
│   ├── options.lua    # Editor options (4-space tabs, relative numbers, etc.)
│   └── keymaps.lua    # Global keybindings
└── plugins/           # One file per plugin (lazy.nvim spec)
```

**Plugin manager**: lazy.nvim (lock file: `nvim/lazy-lock.json` with 41 pinned plugins).

Each plugin file under `plugins/` returns a lazy.nvim spec table. Plugin files are auto-discovered, so there is no central plugin list to update.

**Key plugin categories**:
- LSP: mason + mason-lspconfig + nvim-lspconfig (servers: lua_ls, ts_ls, eslint, cssls, html, pyright, jdtls, kotlin_language_server, nginx_language_server)
- Completion: nvim-cmp + LuaSnip + friendly-snippets
- File finding: telescope + fzf-native
- File explorer: neo-tree
- Formatting: conform.nvim (prettier, stylua, google-java-format, ktlint)
- Linting: nvim-lint (flake8, eslint_d)
- Git: gitsigns + vim-fugitive + diffview
- Theme: catppuccin (Mocha)
- Navigation: vim-tmux-navigator (shared Ctrl+hjkl with tmux)

**Filetype overrides** in `nvim/ftplugin/`: JS and TS use 2-space indentation (override the global 4-space default).

## Tmux Configuration

Single file: `tmux/tmux.conf`. Prefix is `Ctrl+a`. Uses TPM for plugin management. Theme is Catppuccin (Mocha). Pane navigation shared with Neovim via `vim-tmux-navigator` (Ctrl+hjkl).

## Zsh Configuration

`zsh/.zshrc` uses zinit plugin manager. Theme is Powerlevel10k (`zsh/.p10k.zsh`). Integrates fzf, zoxide, and git tooling.

## Conventions

- **Leader key**: Space
- **Theme**: Catppuccin Mocha across all tools
- **Tabs**: 4 spaces globally; 2 spaces for JS/TS (via ftplugin)
- **Lua formatting is pinned** by `stylua.toml` (Spaces, width 2). `formatting.lua` runs stylua on
  every Lua save via conform, and stylua's own defaults are tabs, so this file is what keeps the
  config from being reformatted wholesale. Do not remove it.
- To add a new Neovim plugin: create a new file in `nvim/lua/plugins/` returning a lazy.nvim spec; update `nvim/lazy-lock.json` after installing
- To add LSP servers or formatters: update `nvim/lua/plugins/lsp-config.lua` (mason ensure_installed) and `nvim/lua/plugins/formatting.lua`

## Treesitter

`nvim-treesitter` is pinned to **`branch = "main"`**, the rewrite, because `master` states
"Neovim 0.10 or 0.11 (Neovim 0.12 is not supported)" and this machine runs 0.12.x. Do not move it
to `master`: that produces `languagetree.lua: attempt to call method 'range' (a nil value)`.

The rewrite is a **parser manager only**. There is no `nvim-treesitter.configs`, so the old
`highlight` / `indent` / `incremental_selection` options do not exist:

- **highlighting** comes from Neovim, started per filetype by an autocmd in `treesitter.lua`
- **indent** comes from the plugin via `indentexpr`, marked experimental upstream
- **parser installs** use `get_installed()` plus `install()` on the delta, replacing `ensure_installed`
- **incremental selection** was dropped upstream and is reimplemented in
  `nvim/lua/config/ts-selection.lua` (`<leader>ss` select, `<leader>si` grow, `<leader>sd` shrink)

**`tree-sitter-cli` is a hard requirement** (0.26.1+, via Homebrew, not npm). The rewrite compiles
through `tree-sitter build` rather than calling `cc`, and without the CLI every parser fails with
`ENOENT`. Parsers install to `stdpath("data")/site/parser`, not the plugin directory.

`telescope.nvim` tracks `master`, deliberately **not** the `0.1.x` branch: that branch is frozen at
2024 and its previewer calls `nvim-treesitter.parsers.ft_to_lang`, which only the old treesitter
master provides.

Telescope also needs `ripgrep` (live_grep) and `fd` (find_files) on PATH.

**Do not import `treesitter.lua` or `telescope.lua` from any copy of this config that targets
Neovim 0.11.** Those two files are version-specific and will undo the migration above.

## LeetCode practice

`nvim/lua/plugins/leetcode.lua` overrides an internal `leetcode.nvim` method so solutions land at:

```
~/hq/growth/leetcode/problems/<3-digit-id>-<slug>/NN-<slug>.kt
```

`<leader>Ln` starts the next numbered attempt. **The numbered prefix is load-bearing**: the plugin
finds the latest attempt by matching the exact `NN-<slug>.<ext>` shape, so renaming a solution file
restarts the counter and the next attempt overwrites the previous one. Re-test after plugin
upgrades. Never commit a LeetCode cookie here; it lives outside the repo under
`~/.local/share/nvim/leetcode`.
