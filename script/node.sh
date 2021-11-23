#!/usr/bin/env bash

install() {
  # settings nodebrew in workspace
  nodebrew setup

  # install node from nodebrew
  nodebrew install-binary stable
  nodebrew use stable
  export PATH=$HOME/.nodebrew/current/bin:$PATH

  # check node
  node -v
  npm -v

  # move workspace
  lint_configure_path=$(pwd)/$(dirname $0)/
  workspace=${lint_configure_path}../../
  echo "Move workspace to ${workspace}"
  cd "${workspace}" || exit

  # install textlint component
  ln -snf "${lint_configure_path}"../package.json package.json
  ln -snf "${lint_configure_path}"../package-lock.json package-lock.json
  npm install

  # initialize textlint
  ln -snf "${lint_configure_path}"../.textlintrc .textlintrc

  # configure Markdown Lint(for VS Code : https://github.com/DavidAnson/vscode-markdownlint)
  ln -snf "${lint_configure_path}"../.markdownlint.jsonc .markdownlint.jsonc
}

uninstall() {
  # move workspace
  lint_configure_path=$(pwd)/$(dirname $0)/
  workspace=${lint_configure_path}../../
  echo "Move workspace to ${workspace}"
  cd "${workspace}" || exit

  # uninstall node package
  rm -rf node_module
  unlink package.json
  unlink package-lock.json
  unlink .textlintrc
  unlink .markdownlint.jsonc

  nodebrew clean all
}

usage() {
  echo -e "$0\\n\\tThis script installs nodejs\\n"
  echo "Usage:"
  echo "  install           : install nodejs"
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
