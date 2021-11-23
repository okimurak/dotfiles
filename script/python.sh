#!/usr/bin/env bash

declare -a arr=(
  "3.7.0"
  "3.8.0"
  "3.9.0"
)

install() {
  for pyver in "${arr[@]}"; do
    pyenv install -f "${pyver}"
  done
  pyenv global 3.9.0
  pip install -r "${configure_path}"requirements.txt
}

uninstall() {
  pip uninstall -r "${configure_path}"requirements.txt

  for pyver in "${arr[@]}"; do
    pyenv uninstall -f "${pyver}"
  done
}

usage() {
  echo -e "$0\\n\\tThis script installs Python\\n"
  echo "Usage:"
  echo "  install           : install Python and pip modules"
  echo "  uninstall         : uninstall Python and pip modules"
}

main() {
  local cmd=$1
  base_dir=$(dirname $0)
  configure_path=$(pwd)/${base_dir}/
  source "${base_dir}"/../.profile

  if [[ $cmd == "install" ]]; then
    install
  elif [[ $cmd == "uninstall" ]]; then
    uninstall
  else
    usage
  fi
}

main "$@"
