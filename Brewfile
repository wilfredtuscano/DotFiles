# Brewfile: Homebrew Bundle manifest for this Mac.
#
#   brew bundle --file=Brewfile          install everything listed
#   brew bundle check --file=Brewfile    report what is missing, change nothing
#
# This is a manifest for provisioning a machine, NOT a sync command. On an established
# machine `brew bundle install` also UPGRADES anything outdated, which is how a working
# config gets moved underneath you: a stylua minor bump can change formatting across the
# whole Lua config, a tmux minor bump can affect the status line, and a Neovim major can
# break the treesitter setup outright. Prefer `brew bundle check` to see the drift, then
# upgrade deliberately, one thing at a time.
#
# Reworked 2026-10-12 to cover what this config actually needs. See the tail of this file for
# what is deliberately absent.

# ---- Shell ----
brew "zsh"       # the config targets zsh; macOS ships 5.9, brew tracks newer
brew "fzf"       # fuzzy finder, backs zsh history search and fzf-tab
brew "zoxide"    # smart cd
brew "eza"       # modern ls, aliased in .zshrc
brew "bat"       # better cat, used for fzf previews
brew "tmux"      # terminal multiplexer; tmux.conf clones and installs TPM itself

# ---- Editor ----
# Neovim is plain brew here, NOT bob-managed. The config targets 0.12.x; read the Treesitter
# section of CLAUDE.md before allowing a major jump, since that is how the 0.12 break arrived.
brew "neovim"
# Hard requirement for nvim-treesitter's `main` branch, which compiles through
# `tree-sitter build` rather than calling cc. Without it every parser install fails with ENOENT.
brew "tree-sitter-cli"
brew "ripgrep"   # required by telescope live_grep
brew "fd"        # required by telescope find_files
brew "stylua"    # Lua formatter, run on save by conform and pinned by stylua.toml
brew "lazygit"   # git TUI, opened from nvim with <leader>gg

# ---- General CLI ----
brew "git"       # macOS ships Apple git; brew tracks upstream
brew "node"      # JS and TS language servers plus tooling
brew "jq"        # JSON processor
brew "tldr"      # practical man pages

# ---- GUI ----
cask "iterm2"

# ---- Fonts ----
# Set iTerm2 to the MONO variant, CaskaydiaCoveNFM. The non-Mono build has double-width
# glyphs that break column alignment in a terminal.
cask "font-caskaydia-cove-nerd-font"

# ---- Deliberately not here ----
# bob             Neovim version manager. Not used here: Neovim comes from brew and this
#                 config targets 0.12.x. Pin with bob only if you need to hold an older
#                 Neovim on a machine that cannot run the current one.
# openjdk@17/@21  JDKs come from Temurin (Adoptium) on this machine. Adding brew's openjdk
#                 installs a second, parallel set. jdtls and kotlin-language-server use
#                 whatever `java` resolves to.
# pandoc          Was in the work manifest for an internal publishing workflow.
# obsidian        Not installed here; add it back if you want the notes app.
