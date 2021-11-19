#!/usr/bin/env bash

declare -a arr=(
  "remind101/formulae/assume-role"
  "coreutils" # tac
  "cfn-lint"
  "eksctl"
  "gettext" # envsubst
  "go"
  "git-secrets"
  "hadolint"
  "helm"
  "jq"
  "kubectl"
  "kubectx"
  "lazydocker"
  "peco"
  "pyenv"
  "rain"
  "shellcheck"
  "shfmt"
  "stern"
  "tfenv"
  "yq"
)

install() {
  brew tap weaveworks/tap
  for tool in "${arr[@]}"; do
    brew install "${tool}"
  done
}

uninstall() {
  for tool in "${arr[@]}"; do
    brew uninstall "${tool}"
  done
}

usage() {
  echo -e "$0\\n\\tThis script installs tools from Homebrew\\n"
  echo "Usage:"
  echo "  install           : install from Homebrew"
  echo "  uninstall         : uninstall from Homebrew"
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
