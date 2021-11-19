#!/usr/bin/env bash

install() {
  ## AWS CLI
  autoload bashcompinit && bashcompinit
  autoload -Uz compinit && compinit

  ## eksctl
  mkdir -p ~/.zsh/completion/
  eksctl completion zsh > ~/.zsh/completion/_eksctl

  ## docker-compose
  mkdir -p ~/.zsh/completion
  curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose
}

usage() {
  echo -e "$0\\n\\tThis script installs completer\\n"
  echo "Usage:"
  echo "  install           : install completer of each tools"
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
