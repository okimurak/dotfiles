#!/usr/bin/env bash

# Markdown Lint(for VS Code : https://github.com/DavidAnson/vscode-markdownlint) configure install

base_dir=$(dirname $0)
install_path=$(pwd)/${base_dir}/.markdownlint.jsonc
cd ${base_dir}/../..
ln -snf ${install_path} .markdownlint.jsonc
