#!/usr/bin/env bash

install (){
  # install nodebrew 
  brew install nodebrew

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
  base_dir=$(dirname $0)
  lint_configure_path=$(pwd)/${base_dir}/
  workspace=${lint_configure_path}../../
  echo "Move workspace to ${workspace}"
  cd "${workspace}" || exit

  # install textlint component
  ln -snf "${lint_configure_path}"package.json package.json
  ln -snf "${lint_configure_path}"package-lock.json package-lock.json
  npm install

  # initialize textlint
  npx textlint --init
  rm -f .textlintrc
  ln -snf "${lint_configure_path}".textlintrc .textlintrc 

  # configure Markdown Lint(for VS Code : https://github.com/DavidAnson/vscode-markdownlint)
  ln -snf "${lint_configure_path}".markdownlint.jsonc .markdownlint.jsonc
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
  else
    usage
  fi
}

main "$@"
