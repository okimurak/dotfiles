#!/usr/bin/env bash

install() {
  source "${base_dir}/../.profile"

  for tool_shell in "${arr[@]}"; do
    "./${base_dir}/${tool_shell}" install
  done

  echo -e "\e[1;36m Install completed!!!! \e[m"
}

uninstall() {
  for tool_shell in "${arr[@]}"; do
    "./${base_dir}/${tool_shell}" uninstall
  done
  echo -e "\e[1;36m Uninstall completed!!!! \e[m"
}

usage() {
	echo -e "$0\\n\\tThis script installs basic tools\\n"
	echo "Usage:"
	echo "  install           : install basic tools"
	echo "  uninstall         : uninstall basic tools"
}

base_dir="$(dirname $0)"

declare -a arr=(
  "brew.sh"
  "config.sh"
  "zsh.sh"
  )

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
