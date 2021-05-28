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
lint_configure_path=$(pwd)/${base_dir}/
workspace=${lint_configure_path}../../
echo "Mode workspace to ${workspace}"
cd ${workspace}

# install textlint compo
npm install --save-dev \
    textlint \
    textlint-rule-preset-ja-spacing \
    textlint-rule-preset-ja-technical-writing \
    textlint-rule-spellcheck-tech-word \
    textlint-rule-ja-space-between-half-and-full-width

# Initialize textlint
npx textlint --init
rm -f .textlintrc
ln -snf ${lint_configure_path}.textlintrc .textlintrc 

# Configure Markdown Lint(for VS Code : https://github.com/DavidAnson/vscode-markdownlint)
ln -snf ${lint_configure_path}.markdownlint.jsonc .markdownlint.jsonc
