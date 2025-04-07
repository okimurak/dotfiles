#!/usr/bin/env zsh

install() {
  configuration_path=$(pwd)/$(dirname $0)/
  echo "Move workspace to ${configuration_path}"
  cd "${configuration_path}" || exit

  # Set global git ignore
  mkdir -p "${HOME}/.config/git" && ln -snf "${configuration_path}/git/ignore" "${HOME}/.config/git/ignore"
}

uninstall() {
  #mise uninstall
  unlink "${HOME}/.config/git/ignore"
}

usage() {
  echo -e "$0\\n\\tThis script installs git config files\\n"
  echo "Usage:"
  echo "  install           : install git config files"
  echo "  uninstall         : uninstall git config files"
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
