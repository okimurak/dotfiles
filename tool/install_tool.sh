#!/usr/bin/env bash

base_dir="$(dirname $0)"

declare -a arr=(
  "install_tool_to_brew.sh"
  "install_node.sh"
  "install_python.sh"
  )

for tool_shell in "${arr[@]}"; do
  bash "${base_dir}/${tool_shell}"
done
