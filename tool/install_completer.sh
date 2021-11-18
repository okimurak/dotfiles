
#!/usr/bin/env bash

## AWS CLI
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

## Docker
mkdir -p ~/.zsh/completion
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose
