#!/usr/bin/env bash

source $(dirname $0)/../.profile

declare -a arr=(
  "assume-role"
  "coreutils" # tac
  "gettext" # envsubst
  "git-secrets"
  "hadolint"
  "jq"
  "lazydocker"
  "peco"
  "pyenv"
  "shellcheck"
  "tfenv"
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
