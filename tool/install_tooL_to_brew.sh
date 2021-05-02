#!/usr/bin/env bash

source $(dirname $0)/../.profile

declare -a arr=(
  "jq"
  "peco"
  )

for tool in "${arr[@]}"; do
  brew install ${tool}
done
