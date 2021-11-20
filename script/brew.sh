#!/usr/bin/env bash

install() {
  # Reference https://github.com/homebrew/install#install-homebrew-on-macos-or-linux
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  source "$(dirname $0)"/../.profile "$(dirname $0)"/../.bash_profile

  # Add package
  brew bundle --global
}

uninstall() {
  # Remove package
  brew bundle cleanup --global --force

  # Reference https://github.com/homebrew/install#uninstall-homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
}

usage() {
  echo -e "$0\\n\\tThis script installs Homebrew\\n"
  echo "Usage:"
  echo "  install           : install Homebrew"
  echo "  uninstall         : uninstall Homebrew"
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
