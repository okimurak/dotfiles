#!/usr/bin/env bash
set -xe

# Install Prezto
brew update
brew install zsh

# Change default shell
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s $(which zsh)
