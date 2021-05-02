#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# No deployment blob
setopt nonomatch

# Customize to your needs...
# alies Config
alias ls='ls -FG'

# Git Operation
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gph='git push -u origin HEAD'
alias gpfh='git push -u -f origin HEAD'

# Docker Operation
alias dc='docker container'
alias dcls='docker container ls -a'
alias dcprune='docker container prune'

function docker-search-tags() {
  curl -s -S "https://registry.hub.docker.com/v1/repositories/$1/tags" | jq '.[]["name"]'
}

# Utility
# execute ls after cd
chpwd() {ls}
