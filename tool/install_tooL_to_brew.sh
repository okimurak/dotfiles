#!/usr/bin/env bash

source $(dirname $0)/../.profile

declare -a arr=(
  "remind101/formulae/assume-role"
  "coreutils" # tac
  "cfn-lint"
  "eksctl"
  "gettext" # envsubst
  "go"
  "git-secrets"
  "hadolint"
  "jq"
  "kubectl"
  "kubectx"
  "lazydocker"
  "peco"
  "pyenv"
  "rain"
  "shellcheck"
  "stern"
  "tfenv"
  "yq"
  )


install() {
  brew tap weaveworks/tap
  for tool in "${arr[@]}"; do
    brew install ${tool}
  done
}

uninstall() {
  for tool in "${arr[@]}"; do
    brew uninstall ${tool}
  done
}

install
