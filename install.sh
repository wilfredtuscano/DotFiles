#!/bin/bash
# DotFiles Installation Script

# Create symlinks for all dotfiles
echo "Creating symlinks for dotfiles..."

# Zsh
echo "Setting up zsh configuration..."

# Install zsh if not present
if ! command -v zsh &> /dev/null; then
    echo "Installing zsh..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install zsh
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update && sudo apt-get install -y zsh
    fi
fi

# Set zsh as default shell
if [[ "$SHELL" != *"zsh" ]]; then
    echo "Setting zsh as default shell..."
    chsh -s $(which zsh)
fi

# Backup existing zshrc
if [[ -f ~/.zshrc ]]; then
    echo "Backing up existing .zshrc..."
    cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
fi

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create symlinks
ln -sf "$SCRIPT_DIR/zsh/.zshrc" ~/.zshrc
ln -sf "$SCRIPT_DIR/zsh/.p10k.zsh" ~/.p10k.zsh
echo "✓ Zsh config linked"

echo "Dotfiles installation complete!"

