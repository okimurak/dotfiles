#!/usr/bin/env bash
set -xe

install() {
  # Install Prezto
  brew update
  brew install zsh

  # Change default shell
  command -v zsh | sudo tee -a /etc/shells
  sudo chsh -s "$(which zsh)"

  base_dir="$(dirname $0)"
  ./"${base_dir}"/zsh_config.sh
}

uninstall() {
  # prezto
  rm -rf ~/.zprezto ~/.zlogin ~/.zlogout ~/.zpreztorc ~/.zprofile ~/.zshenv ~/.zshrc

  # zsh
  brew uninstall romkatv/powerlevel10k/powerlevel10k
  brew uninstall zsh
}

usage() {
  echo -e "$0\\n\\tThis script installs Homebrew\\n"
  echo "Usage:"
  echo "  install           : install zsh"
  echo "  uninstall         : uninstall zsh"
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
