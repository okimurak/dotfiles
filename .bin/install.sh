#!/usr/bin/env bash

base_dir="$(dirname $0)"

declare -a arr=(
  "install_brew.sh"
  "install_config.sh"
  "install_zsh.sh"
  "install_zsh_config.sh"
  )


source $(dirname $0)/../.profile
for tool_shell in "${arr[@]}"; do
  "./${base_dir}/${tool_shell}"
done

echo -e "\e[1;36m Install completed!!!! \e[m"
