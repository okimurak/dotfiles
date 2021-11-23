#!/usr/bin/env bash

base_dir="$(dirname $0)"

declare -a arr=(
  "node.sh"
)

install() {
  for tool_shell in "${arr[@]}"; do
    ./"${base_dir}/${tool_shell}" install
  done

  echo -e "\e[1;36m Tool install completed!!!! \e[m"
}

uninstall() {
  for tool_shell in "${arr[@]}"; do
    ./"${base_dir}/${tool_shell}" uninstall
  done
  echo -e "\e[1;36m Tool uninstall completed!!!! \e[m"
}

usage() {
  echo -e "$0\\n\\tThis script installs tools\\n"
  echo "Usage:"
  echo "  install           : install tools"
  echo "  uninstall         : uninstall tool"
}

main() {
  local cmd=$1
  source "$(dirname $0)"/../.profile

  if [[ $cmd == "install" ]]; then
    install
  elif [[ $cmd == "uninstall" ]]; then
    uninstall
  else
    usage
  fi
}

main "$@"
