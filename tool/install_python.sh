#!/usr/bin/env bash

source $(dirname $0)/../.profile

declare -a arr=(
  "3.7.0"
  "3.8.0"
  "3.9.0"
  )

install() {
  for pyver in "${arr[@]}"; do
    pyenv install -f  ${pyver}
  done
}

install
