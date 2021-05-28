#!/usr/bin/env bash

source $(dirname $0)/../.profile

# nodebrew install
brew install nodebrew

# nodebrew settings in workspace
nodebrew setup

# install node from nodebrew
nodebrew install-binary stable
nodebrew use stable
export PATH=$HOME/.nodebrew/current/bin:$PATH

# node install check
node -v
npm -v

# move workspace
base_dir=$(dirname $0)
workspace=${base_dir}/../..
textlintrc_path=$(pwd)/${base_dir}/.textlintrc 
cd ${workspace}

# install textlint compo
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
