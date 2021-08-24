#!/usr/bin/env bash

base_dir=$(dirname $0)
configure_path=$(pwd)/${base_dir}/
source ${base_dir}/../.profile

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

pyenv global 3.9.0

pip install -r ${configure_path}requirements.txt
