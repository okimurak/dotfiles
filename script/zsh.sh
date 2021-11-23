#!/usr/bin/env zsh
set -xe

install() {
  # Change default shell
  command -v zsh | sudo tee -a /etc/shells
  sudo chsh -s "$(which zsh)"

  # Install Prezto
  if [[ -e "${ZDOTDIR:-$HOME}/.zprezto" ]]; then
    rm -rf "${ZDOTDIR:-$HOME}/.zprezto"
  fi

  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done

  # Install Powerlevel10k(https://github.com/romkatv/powerlevel10k)
  zstyle ':prezto:module:prompt' theme 'powerlevel10k'
}

uninstall() {
  # remove zsh,prezto dotfiles
  rm -rf ~/.zprezto ~/.zlogin ~/.zlogout ~/.zpreztorc ~/.zprofile
}

usage() {
  echo -e "$0\\n\\tThis script installs zsh and prezto\\n"
  echo "Usage:"
  echo "  install           : install zsh and prezto"
  echo "  uninstall         : uninstall zsh and prezto"
}

main() {
  local cmd=$1

  if [[ $cmd == "install" ]]; then
    install
  elif [[ $cmd == "uninstall" ]]; then
    uninstall
  else
    usage
  fi
}

main "$@"
