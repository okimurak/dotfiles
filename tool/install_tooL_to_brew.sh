#!/usr/bin/env bash

source $(dirname $0)/../.profile

declare -a arr=(
  "assume-role"
  "coreutils" # tac
  "gettext" # envsubst
  "git-secrets"
  "hado-lint"
  "jq"
  "lazydocker"
  "peco"
  "pyenv"
  "shellcheck"
  "tfenv"
  )

for tool in "${arr[@]}"; do
  brew install ${tool}
done
