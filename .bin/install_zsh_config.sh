#!/usr/bin/env zsh

# Install Prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# Install Powerlevel10k(https://github.com/romkatv/powerlevel10k)
brew install romkatv/powerlevel10k/powerlevel10k
zstyle ':prezto:module:prompt' theme 'powerlevel10k'
