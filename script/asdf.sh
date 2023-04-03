#!/usr/bin/env bash

# ref : https://asdf-vm.com/manage/core.html#installation-setup

add-plugin() {
  asdf plugin add awscli https://github.com/MetricMike/asdf-awscli.git
  asdf plugin add aws-copilot https://github.com/NeoHsu/asdf-copilot.git
  asdf plugin add awsebcli https://github.com/amrox/asdf-pyapp.git
  asdf plugin add aws-sam-cli https://github.com/amrox/asdf-pyapp.git
  asdf plugin-add deno https://github.com/asdf-community/asdf-deno.git
  asdf plugin-add eksctl https://github.com/elementalvoid/asdf-eksctl.git
  asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
  asdf plugin add hadolint https://github.com/devlincashman/asdf-hadolint.git
  asdf plugin-add helm https://github.com/Antiarchitect/asdf-helm.git
  asdf plugin-add jq https://github.com/AZMCode/asdf-jq.git
  asdf plugin-add kubectl https://github.com/Banno/asdf-kubectl.git
  asdf plugin-add kubectx https://gitlab.com/wt0f/asdf-kubectx
  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  asdf plugin add peco https://github.com/asdf-community/asdf-peco.git
  asdf plugin-add python https://github.com/danhper/asdf-python.git
  asdf plugin add shellcheck https://github.com/luizm/asdf-shellcheck.git
  asdf plugin-add shfmt https://github.com/luizm/asdf-shfmt.git
  asdf plugin-add stern https://github.com/looztra/asdf-stern
  asdf plugin-add terraform https://github.com/Banno/asdf-hashicorp.git
  asdf plugin-add yq https://github.com/sudermanjr/asdf-yq.git

  asdf plugin list
}

install() {
  ASDF_VERSION=v0.11.1
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch "${ASDF_VERSION}"
  . "${HOME}"/.asdf/asdf.sh

  # Add plugin
  add-plugin

  configure_path=$(pwd)/$(dirname $0)/
  workspace=${configure_path}../
  echo "Move workspace to ${workspace}"
  cd "${workspace}" || exit

  # Copy dotfile for asdf
  ln -snf "${configure_path}"../.tool-versions "${HOME}"/.tool-versions

  # Install packages (global)
  asdf install
  asdf current
  . "${HOME}"/.asdf/asdf.sh
}


uninstall() {
  rm -rf "${ASDF_DATA_DIR:-$HOME/.asdf}"
  rm -rf "${HOME}"/.tool-versions "${HOME}"/.asdfrc
}

update() {
  asdf update
  add-plugin
  asdf install
}

usage() {
  echo -e "$0\\n\\tThis script installs asdf and asdf plugins\\n"
  echo "Usage:"
  echo "  install           : install asdf"
  echo "  uninstall         : uninstall asdf"
}

main() {
  local cmd=$1

  if [[ $cmd == "install" ]]; then
    install
  elif [[ $cmd == "uninstall" ]]; then
    uninstall
  elif [[ $cmd == "update" ]]; then
    update
  else
    usage
  fi
}

main "$@"
