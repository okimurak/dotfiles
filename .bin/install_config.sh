#!/usr/bin/env bash
# reference : https://qiita.com/b4b4r07/items/24872cdcbec964ce2178
set -ue

helpmsg() {
  command echo "Usage: $0 [--help | -h]" 0>&2
  command echo ""
}

link_to_homedir() {
  local dot_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
  for f in .??*
  do
    [[ `basename $f` == ".bin" ]] && continue
    [[ `basename $f` == ".git" ]] && continue

    if [[ -L "$HOME/$f" ]];then
      rm -f "$HOME/$f"
    fi
    ln -snf "$dot_dir/$f" "$HOME/$f"
  done
}

while [ $# -gt 0 ];do
  case ${1} in
    --debug|-d)
      set -uex
      ;;
    --help|-h)
      helpmsg
      exit 1
      ;;
    *)
      ;;
  esac
  shift
done

link_to_homedir
git config --global include.path "~/.gitconfig_shared"
