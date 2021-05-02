#!/usr/bin/env bash

base_dir="$(dirname $0)"

declare -a arr=(
  "go_install.sh"
  "nodesettings.sh"
  "markdownlint.sh"
  )

for tool_shell in "${arr[@]}"; do
  bash "${base_dir}/${tool_shell}"
done
