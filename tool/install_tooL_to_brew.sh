#!/usr/bin/env bash

source $(dirname $0)/../.profile

declare -a arr=(
  "remind101/formulae/assume-role"
  "coreutils" # tac
  "cfn-lint"
  "gettext" # envsubst
  "go"
  "git-secrets"
  "hadolint"
  "jq"
  "lazydocker"
  "peco"
  "pyenv"
  "rain"
  "shellcheck"
  "tfenv"
  "yq"
  )


install() {
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
