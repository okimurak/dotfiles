#!/usr/bin/env bash

# Install Prezto
source $(dirname $0)/../.profile
brew update
brew install zsh

# Change default shell
command -v zsh | sudo tee -a /etc/shells
chsh -s $(which zsh)
