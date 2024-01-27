#!/usr/bin/env zsh

install() {
  configuration_path=$(pwd)/$(dirname $0)/
  echo "Move workspace to ${configuration_path}"
  cd "${configuration_path}" || exit

  # Install packages (global)
  source "${configuration_path}/.zshrc"
  mkdir -p "${HOME}/.config/mise" && ln -snf "${configuration_path}/config.toml" "${HOME}/.config//mise/config.toml"
  mise install
  mise ls
}

update() {
  # Update tools
  mise install
  mise ls
}

uninstall() {
  #mise uninstall
  unlink "${HOME}/.config/mise/config.toml"
  rm -rf "${HOME}/.config/mise/"
}

usage() {
  echo -e "$0\\n\\tThis script installs mise(asdf) plugins\\n"
  echo "Usage:"
  echo "  install           : install mise(asdf) plugins"
  echo "  uninstall         : uninstall mise(asdf) plugins"
}

main() {
  local cmd=$1

  if [[ $cmd == "install" ]]; then
    install
  elif [[ $cmd == "update" ]]; then
    update
  elif [[ $cmd == "uninstall" ]]; then
    uninstall
  else
    usage
  fi
}

main "$@"
