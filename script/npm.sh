#!/usr/bin/env bash

# Define an tool of configuration files
NPM_CONFIG_FILES=(
  "package.json"
  "package-lock.json"
)

TOOL_CONFIG_FILES=(
  ".textlintrc"
  ".markdownlint.jsonc" # https://github.com/DavidAnson/vscode-markdownlint
  "biome.json"
)

install() {
  # move workspace
  lint_configure_path=$(pwd)/$(dirname $0)/
  workspace=${lint_configure_path}../../
  echo "Move workspace to ${workspace}"
  cd "${workspace}" || exit

  # install textlint component
  for config_file in "${NPM_CONFIG_FILES[@]}"; do
    ln -snf "${lint_configure_path}"../"${config_file}" "${config_file}"
  done
  npm install

  # Create symbolic links for configuration files
  for config_file in "${TOOL_CONFIG_FILES[@]}"; do
    ln -snf "${lint_configure_path}"../"${config_file}" "${config_file}"
  done
}

uninstall() {
  # move workspace
  lint_configure_path=$(pwd)/$(dirname $0)/
  workspace=${lint_configure_path}../../
  echo "Move workspace to ${workspace}"
  cd "${workspace}" || exit

  # uninstall node package
  rm -rf node_modules
  # Remove symbolic links for configuration files
  for config_file in "${NPM_CONFIG_FILES[@]}" "${TOOL_CONFIG_FILES[@]}"; do
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
