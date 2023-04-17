#!/usr/bin/env zsh

install() {
  # Change default shell
  command -v zsh | sudo tee -a /etc/shells
  sudo chsh -s "$(which zsh)"
  configuration_path=$(pwd)/$(dirname $0)

  mkdir -p "${HOME}/.config" && ln -snf "${configuration_path}/starship.toml" "${HOME}/.config/starship.toml"
  # Install zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-autosuggestions "${configuration_path}/.zsh/zsh-autosuggestions"
}

uninstall() {
  # remove zsh,prezto dotfiles
  unlink "${HOME}/.config/starship.toml"
  rm -rf "${HOME}/.zsh/zsh-autosuggestions"
}

usage() {
  echo -e "$0\\n\\tThis script configure zsh and starship\\n"
  echo "Usage:"
  echo "  install           : install zsh and starship"
  echo "  uninstall         : uninstall zsh and starship"
}

main() {
  local cmd=$1

  if [[ $cmd == "install" ]]; then
    install
  elif [[ $cmd == "uninstall" ]]; then
    uninstall
  else
    usage
  fi
}

main "$@"
