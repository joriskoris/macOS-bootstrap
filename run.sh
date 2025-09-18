#!/usr/bin/env bash
set -e

if ! which brew &> /dev/null; then
  echo "Homebrew is not installed. Installing now..."
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | /bin/bash
else
  echo "Homebrew is already installed."
fi


brew_install() {
    printf "\nInstalling %s" "$1"
    if brew list "$1" &>/dev/null; then
        echo "${1} is already installed"
    else
        brew install "$1" && echo "$1 is installed"
    fi
}

brew_install "ansible"

printf "\nRunning Ansible playbook to bootstrap macOS..."

ansible-playbook setup.yaml
