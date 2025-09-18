#!/usr/bin/env bash
set -e

if ! which brew &> /dev/null; then
  echo "Homebrew is not installed. Installing now..."
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | /bin/bash
else
  echo "Homebrew is already installed."
fi

# Install uv if not already installed
if ! which uv &> /dev/null; then
  echo "Installing uv..."
  brew install uv
fi

# Set up Python project if not exists
if [ ! -f "pyproject.toml" ]; then
  echo "Setting up Python project..."
  uv init --python 3.12
  uv add pyyaml
fi

printf "\nGenerating Brewfile for profile: %s..." "${1:-all}"

if [ "$1" = "work" ]; then
    uv run python generate_brewfile.py work > Brewfile
    echo "Generated work profile Brewfile"
else
    uv run python generate_brewfile.py > Brewfile
    echo "Generated full profile Brewfile"
fi

printf "\nInstalling packages with brew bundle..."
brew bundle install

printf "\nCleaning up packages not in Brewfile..."
brew bundle cleanup --force
