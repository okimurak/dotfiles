#!/usr/bin/env bash

install() {
  # Reference https://github.com/homebrew/install#install-homebrew-on-macos-or-linux
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  source "$(dirname $0)"/../.profile "$(dirname $0)"/../.bash_profile

  # Add package
  brew bundle --file "$(dirname $0)"/../.Brewfile
}

uninstall() {
  # Remove package
  brew bundle cleanup --file "$(dirname $0)"/../.Brewfile --force 

  # Reference https://github.com/homebrew/install#uninstall-homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
}

update() {
  brew bundle --file "$(dirname $0)"/../.Brewfile
}

usage() {
  echo -e "$0\\n\\tThis script installs Homebrew\\n"
  echo "Usage:"
  echo "  install           : install Homebrew"
  echo "  update            : update tools from Homebrew"
  echo "  uninstall         : uninstall Homebrew"
}

main() {
  local cmd=$1

  if [[ $cmd == "install" ]]; then
    install
  elif [[ $cmd == "uninstall" ]]; then
    uninstall
  elif [[ $cmd == "update" ]]; then
    update
  else
    usage
  fi
}

main "$@"
