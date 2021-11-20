#!/usr/bin/env bash
set -xe

install() {
  # Change default shell
  command -v zsh | sudo tee -a /etc/shells
  sudo chsh -s "$(which zsh)"

  base_dir="$(dirname $0)"
  ./"${base_dir}"/zsh_config.sh
}

uninstall() {
  # rremove zdh,prezto dotfiles
  rm -rf ~/.zprezto ~/.zlogin ~/.zlogout ~/.zpreztorc ~/.zprofile
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
