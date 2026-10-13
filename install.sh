#!/usr/bin/env bash
# DotFiles installation: create the symlinks this repo owns.
#
# Idempotent. A link already pointing at the right target is left alone; anything else is
# moved aside to a timestamped backup first. Linking happens BEFORE the optional default-shell
# step, so a chsh that fails or prompts cannot leave the config unlinked.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# link <target> <link-path>
link() {
  local target="$1" link_path="$2"

  if [[ -L "$link_path" && "$(readlink "$link_path")" == "$target" ]]; then
    echo "  already linked: ${link_path/#$HOME/~}"
    return
  fi

  # -e is false for a dangling symlink, so test -L as well.
  if [[ -e "$link_path" || -L "$link_path" ]]; then
    local backup="$link_path.backup.$(date +%Y%m%d_%H%M%S)"
    echo "  backing up ${link_path/#$HOME/~} -> ${backup/#$HOME/~}"
    mv "$link_path" "$backup"
  fi

  mkdir -p "$(dirname "$link_path")"
  # -n is essential for the nvim DIRECTORY link: without it, ln follows an existing directory
  # symlink and nests the new link inside the target instead of replacing it.
  ln -sfn "$target" "$link_path"
  echo "  linked: ${link_path/#$HOME/~}"
}

echo "Linking dotfiles..."
link "$SCRIPT_DIR/zsh/.zshrc" "$HOME/.zshrc"
link "$SCRIPT_DIR/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
link "$SCRIPT_DIR/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
link "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"

# Machine-local shell config. Created from templates only when absent, never overwritten:
# these files are the user's and are not version controlled.
echo "Machine-local shell config..."
for suffix in pre post; do
  local_file="$HOME/.zshrc.local.$suffix"
  template="$SCRIPT_DIR/zsh/.zshrc.local.${suffix}.template"
  if [[ ! -f "$local_file" && -f "$template" ]]; then
    cp "$template" "$local_file"
    echo "  created ~/.zshrc.local.$suffix from template"
  else
    echo "  ~/.zshrc.local.$suffix already present"
  fi
done

# nvim/lua/config/options.lua sets undofile with undodir = ~/.undodir, which nvim will not
# create for itself.
mkdir -p "$HOME/.undodir"
echo "  ~/.undodir ready"

# Optional, and last because it can prompt for a password or fail outright.
if [[ "${SHELL:-}" != *zsh ]]; then
  echo "Default shell is not zsh. To change it:"
  echo "  chsh -s \"\$(command -v zsh)\""
fi

echo "Dotfiles installation complete."
