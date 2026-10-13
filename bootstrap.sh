#!/usr/bin/env bash
# bootstrap.sh: take a fresh Mac to "tools installed and dotfiles linked". Idempotent.
#
# Read this file and Brewfile before running it. brew bundle installs GUI applications and
# fonts, and install.sh moves existing config files aside into timestamped backups.
#
# Run from the repo root: ./bootstrap.sh
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This script targets macOS." >&2
  exit 1
fi

# 1. Xcode Command Line Tools. Also provides the C compiler that treesitter parsers need.
if ! xcode-select -p >/dev/null 2>&1; then
  echo "==> Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "    Re-run ./bootstrap.sh once that finishes."
  exit 0
fi

# 2. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)" # Apple silicon
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)" # Intel
fi

# 3. Packages
echo "==> brew bundle..."
brew bundle --file="$SCRIPT_DIR/Brewfile"

# 4. Symlinks
echo "==> Linking dotfiles (install.sh)..."
"$SCRIPT_DIR/install.sh"

cat <<'NEXT'

==> Foundation ready.

    Happens by itself on first launch, nothing to do:
      nvim   lazy.nvim installs plugins, Mason installs language servers and formatters,
             nvim-treesitter compiles parsers using tree-sitter-cli from the Brewfile
      tmux   tmux.conf clones TPM and installs its plugins

    Still manual:
      1. JDK, if you want Java or Kotlin. Install Temurin from https://adoptium.net;
         brew's openjdk is deliberately not in the Brewfile.
      2. iTerm2 font: CaskaydiaCove Nerd Font MONO, not the non-Mono variant.
      3. LeetCode sign-in happens inside nvim. Never put that cookie in this repo.
      4. Machine-local shell config goes in ~/.zshrc.local.pre and ~/.zshrc.local.post,
         copied from the templates in zsh/.
NEXT
