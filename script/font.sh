#!/usr/bin/env bash

install() {
  # TODO
  git clone https://github.com/ryanoasis/nerd-fonts.git $FONT_DIR --depth=1
  cd $FONT_DIR
  ./install.sh 3270
}

uninstall() {
  # TODO
  rm -rf $FONT_DIR
}

usage() {
  echo -e "$0\\n\\tThis script installs powerline fonts.\\n"
  echo "Usage:"
  echo "  install           : install font"
  echo "  uninstall         : uninstall fonts"
}


main() {
  local cmd=$1
  FONT_DIR="${HOME}/.fonts"

  if [[ $cmd == "install" ]]; then
    install
  elif [[ $cmd == "uninstall" ]]; then
    uninstall
  else
    usage
  fi
}

main "$@"
