
#!/usr/bin/env bash

## AWS CLI
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

## eksctl
mkdir -p ~/.zsh/completion/
eksctl completion zsh > ~/.zsh/completion/_eksctl

## docker-compose
mkdir -p ~/.zsh/completion
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose
