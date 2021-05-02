#!/usr/bin/env bash

base_dir="$(dirname $0)"

declare -a arr=(
  "uninstall_zsh.sh"
  "uninstall_config.sh"
  "uninstall_brew.sh"
  )

for tool_shell in "${arr[@]}"; do
  "./${base_dir}/${tool_shell}"
done

echo -e "\e[1;36m Uninstall completed!!!! \e[m"
