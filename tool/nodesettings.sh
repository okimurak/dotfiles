#!/usr/bin/env bash

# node install
sudo apt update && sudo apt install nodejs npm

# move workspace
base_dir=$(dirname $0)
workspace=${base_dir}/../..
textlintrc_path=$(pwd)/${base_dir}/.textlintrc 
cd ${workspace}

# node settings in workspace
npm init -y

npm install --save-dev \
    textlint \
    textlint-rule-preset-ja-spacing \
    textlint-rule-preset-ja-technical-writing \
    textlint-rule-spellcheck-tech-word \
    textlint-rule-ja-space-between-half-and-full-width

# initialize textlint
npx textlint --init
rm -f .textlintrc
ln -snf ${textlintrc_path} .textlintrc 
