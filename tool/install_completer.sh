#!/usr/bin/env bash

## Setup completion dir
mkdir -p ~/${fpath[1]}

## AWS CLI
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

## docker-compose
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/zsh/_docker-compose > "${fpath[1]}_docker-compose"
