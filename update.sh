#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Echo the script directory
echo "Script directory: $SCRIPT_DIR"

# Check if .zshrc exists and then copy it
if [ -f "$HOME/.zshrc" ]; then
  cp "$HOME/.zshrc" "$SCRIPT_DIR"
  echo ".zshrc copied to $SCRIPT_DIR"
else
  echo ".zshrc not found in $HOME"
fi

# Copy the custom oh-my-zsh directory
if [ -d "$HOME/.oh-my-zsh/custom" ]; then
  rsync -a --exclude ".git" "$HOME/.oh-my-zsh/custom" "$SCRIPT_DIR"
  echo "Custom Oh-My-Zsh directory copied to $SCRIPT_DIR"
else
  echo "Custom Oh-My-Zsh directory not found in $HOME"
fi

echo "Zsh config update complete!"