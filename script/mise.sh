#!/usr/bin/env zsh

INSTALL_MISE_VERSION=v2025.11.9

install() {
  install_mise
  install_package
}

install_package() {
  configuration_path=$(pwd)/$(dirname $0)/
  echo "Move workspace to ${configuration_path}"
  cd "${configuration_path}" || exit

  # Install packages (global)
  mkdir -p "${HOME}/.config/mise" && ln -snf "${configuration_path}/config.toml" "${HOME}/.config/mise/config.toml"
  mise install
  mise ls
  source "${configuration_path}/.zshrc"
}

install_mise() {
  if is_mise_installed; then
    echo "mise is already installed."
    return 0
  fi

  curl https://mise.run | MISE_VERSION="${INSTALL_MISE_VERSION}" sh
}

is_mise_installed() {
  if command -v mise >/dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}

update() {
  # Update tools
  mise self-update
  mise install
  mise ls
}

uninstall() {
  uninstall_package
  uninstall_mise
}

uninstall_package() {
  mise uninstall -a
  unlink "${HOME}/.config/mise/config.toml"
  rm -rf "${HOME}/.config/mise/"
}

uninstall_mise() {
  mise implode
  if ! is_mise_installed; then
    print_success "mise uninstallation completed successfully."
  else
    return 1
  fi
}

usage() {
  echo -e "$0\\n\\tThis script installs mise plugins\\n"
  echo "Usage:"
  echo "  install           : install mise plugins"
  echo "  update            : update mise plugins"
  echo "  uninstall         : uninstall mise plugins"
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
