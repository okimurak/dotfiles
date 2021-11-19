#!/usr/bin/env bash
# reference : https://qiita.com/b4b4r07/items/24872cdcbec964ce2178
set -ue

install() {
  local dot_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
  for f in .??*; do
    [[ $(basename "$f") == ".bin" ]] && continue
    [[ $(basename "$f") == ".git" ]] && continue

    if [[ -L "$HOME/$f" ]]; then
      rm -f "$HOME/$f"
    fi
    ln -snf "$dot_dir/$f" "$HOME/$f"
  done
  git config --global include.path "${HOME}/.gitconfig_shared"
}

uninstall() {
  local dot_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
  for f in .??*; do
    [[ $(basename "$f") == ".bin" ]] && continue
    [[ $(basename "$f") == ".git" ]] && continue

    if [[ -L "$HOME/$f" ]]; then
      rm -f "$HOME/$f"
    fi
    unlink "$HOME/$f"
  done
}

usage() {
  echo -e "$0\\n\\tThis script installs config files\\n"
  echo "Usage:"
  echo "  install           : install config"
  echo "  uninstall         : uninstall config"
  echo "  --debug | -d      : debug mode"
  echo "  --help  | -h      : usage this script"
}

while [ $# -gt 0 ]; do
  case ${1} in
  --debug | -d)
    set -uex
    ;;
  --help | -h)
    helpmsg
    exit 1
    ;;
  install)
    install
    ;;
  uninstall)
    uninstall
    ;;
  *)
    helpmsg
    ;;
  esac
  shift
done
