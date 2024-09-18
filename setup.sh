#!/bin/bash

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Setting up Zsh config"

if [ -f "$HOME/.zshrc" ]; then
    echo "Backing up existing .zshrc to .zshrc.bak"
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi

ln -s "$SCRIPT_DIR"/.zshrc "$HOME"/.zshrc
echo "Symlinked .zshrc from $SCRIPT_DIR to $HOME/.zshrc"

if [ -d "$HOME/.oh-my-zsh/custom" ]; then
  echo "Setting up custom plugins and themes..."

  # Copy custom plugins and themes from the repo
  rsync -a --exclude='.git' "$SCRIPT_DIR/custom/" "$HOME/.oh-my-zsh/custom/"
  
  echo "Custom plugins and themes have been set up."
else
  echo "Error: ~/.oh-my-zsh/custom directory does not exist!"
fi

# Source the new .zshrc to apply changes
source "$HOME/.zshrc"

echo "Zsh setup complete!"
