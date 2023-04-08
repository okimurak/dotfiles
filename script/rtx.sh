#!/usr/bin/env zsh

install() {
  configure_path=$(pwd)/$(dirname $0)/
  echo "Move workspace to ${configure_path}"
  cd "${configure_path}" || exit

  # Install packages (global)
  source "${configure_path}/.zshrc"
  rtx install
  rtx ls
}

update() {
  # Update tools
  rtx install
  rtx ls
}

usage() {
  echo -e "$0\\n\\tThis script installs asdf plugins\\n"
  echo "Usage:"
  echo "  install           : install asdf plugins"
}

main() {
  local cmd=$1

  if [[ $cmd == "install" ]]; then
    install
  elif [[ $cmd == "update" ]]; then
    update
  else
    usage
  fi
}

main "$@"
