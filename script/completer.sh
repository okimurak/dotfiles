#!/usr/bin/env zsh

install() {
  # Replace install
  workspace="$(dirname $0)"
  completion_path=${workspace}/.zsh/completion
  if [[ ! -d "${completion_path}" ]]; then
    mkdir -p "${completion_path}"
    chmod 755 ${workspace}/.zsh/
    chmod 755 ${completion_path}
  else
    rm -rf "${completion_path}/*"
  fi

  ## docker, docker-compose
  curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker >"${completion_path}/_docker"

  ## eksctl
  eksctl completion zsh >"${completion_path}/_eksctl"

  ## Git
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash >"${completion_path}/git-completion.bash"
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh >"${completion_path}/_git"

  ## helm
  helm completion zsh >"${completion_path}/_helm"

  ## kubectl
  kubectl completion zsh >"${completion_path}/_kubectl"

  ## yq
  yq shell-completion zsh >"${completion_path}/_yq"

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
