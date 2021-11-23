#!/usr/bin/env bash

declare -a arr=(
  "3.7.0"
  "3.9.0"
)

install() {
  for pyver in "${arr[@]}"; do
    pyenv install -f "${pyver}"
  done
  source "${base_dir}"/../.profile
  pyenv global 3.9.0
  pipenv --python 3.9
  cd "${base_dir}"/.. && pipenv install
}

uninstall() {
  cd "${base_dir}"/.. && pipenv uninstall --all

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
