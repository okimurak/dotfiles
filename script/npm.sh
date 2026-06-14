#!/usr/bin/env bash

# Define an tool of configuration files
TOOL_CONFIG_FILES=(
  ".textlintrc"
  ".markdownlint.jsonc" # https://github.com/DavidAnson/vscode-markdownlint
  "biome.json"
)

install() {
  # move workspace
  move_workspace

  # Install npm dependencies via mise deps (textlint + rules)
  install_deps

  # Create symbolic links for configuration files
  for config_file in "${TOOL_CONFIG_FILES[@]}"; do
    ln -snf "${lint_configure_path}"../"${config_file}" "${config_file}"
  done
}

install_deps() {
  echo "Installing npm dependencies via mise deps..."
  MISE_EXPERIMENTAL=1 mise deps -C "${lint_configure_path}/.."
}

move_workspace() {
  # move workspace
  lint_configure_path=$(pwd)/$(dirname "$0")/
  workspace=${lint_configure_path}../../
  echo "Move workspace to ${workspace}"
  cd "${workspace}" || exit
}

uninstall() {
  # move workspace
  move_workspace

  # Remove node_modules
  rm -rf "${lint_configure_path}/../node_modules"

  # Remove symbolic links for configuration files
  for config_file in "${TOOL_CONFIG_FILES[@]}"; do
    unlink "${config_file}"
  done
}

usage() {
  echo -e "$0\\n\\tThis script installs npm\\n"
  echo "Usage:"
  echo "  install           : install npm tool"
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
