#!/usr/bin/env bash

install() {
  # Replace install
  workspace="$(dirname $0)"../

  rm -rf "${workspace}/.zsh/completion/*"

  ## docker, docker-compose
  curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker >"${workspace}/.zsh/completion/_docker"

  ## eksctl
  eksctl completion zsh >"${workspace}/.zsh/completion/_eksctl"

  ## Git
  curl -o git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash >"${workspace}/.zsh/completion/git-completion.bash"
  curl -o https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh >"${workspace}/.zsh/completion/_git"

  ## helm
  helm completion zsh >"${workspace}/.zsh/completion/_eksctl"

  ## kubectl
  kubectl completion zsh >"${workspace}/.zsh/completion/_kubectl"

  ## yq
  yq shell-completion zsh >"${workspace}/.zsh/completion/_yq"

  source "${workspace}/.zshrc"
}

usage() {
  echo -e "$0\\n\\tThis script installs completer\\n"
  echo "Usage:"
  echo "  install           : replace install completer of each tool completer"
}

main() {
  local cmd=$1
  source "$(dirname $0)"/../.profile

  if [[ $cmd == "install" ]]; then
    install
  else
    usage
  fi
}

main "$@"
