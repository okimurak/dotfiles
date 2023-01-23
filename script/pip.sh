#!/usr/bin/env bash

install() {
  source "${base_dir}"/../.profile
  python -m pip install pipenv
  asdf reshim python
  pipenv --python 3.9
  cd "${base_dir}"/.. && pipenv install
}

uninstall() {
  cd "${base_dir}"/.. && pipenv uninstall --all
  python -m pip install uninstall pipenv
  asdf reshim python
}

usage() {
  echo -e "$0\\n\\tThis script installs Python\\n"
  echo "Usage:"
  echo "  install           : install pip modules"
  echo "  uninstall         : uninstall pip modules"
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
