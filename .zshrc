# ----------------- Application ---------------------
# General
source ~/.profile
setopt nonomatch    # No deployment blob

# Execute "ls" after "cd"
chpwd() {ls}

# mise
eval "$($(brew --prefix)/bin/mise activate zsh)"

# ----------------- Alias ---------------------

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

# Kubernetes Operation
alias k='kubectl'

# ----------------- Completer ---------------------

fpath=(~/.zsh/completion $fpath)
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

## aws cli
autoload -U bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '$(which aws_completer)' aws

# ----------------- Function ---------------------
function docker-search-tags() {
  curl -s -S "https://registry.hub.docker.com/v1/repositories/$1/tags" | jq '.[]["name"]'
}

function docker-delete-all-images() {
  docker images | awk 'NR>1 {print $1 ":" $2}' | xargs docker image rm
}

function git-delete-other-mainbranch() {
  git branch | grep -Ev "master|main" | xargs git branch -D
}

function kc() {
  kubectx | peco | xargs kubectx
}

# peco
function peco-history-selection() {
  BUFFER=`history -n 1 | tac | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/'`
  CURSOR=$#BUFFER
  zle -R -c
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

function s3-delete-all-version() {
  # "${1}" : bucket name
  aws s3api list-object-versions --bucket "${1}" --query 'Versions[?IsLatest==`true`].[Key,VersionId]' --output text | while read -r KEY VER
  do
    aws s3api delete-object --bucket "${1}" --key "${KEY}" --version-id "${VER}"
  done
  aws s3api list-object-versions --bucket "${1}" --query 'Versions[?IsLatest==`false`].[Key,VersionId]' --output text | while read -r KEY VER
  do
    aws s3api delete-object --bucket "${1}" --key "${KEY}" --version-id "${VER}"
  done
  aws s3api list-object-versions --bucket "${1}" --query 'DeleteMarkers[?IsLatest==`true`].[Key,VersionId]' --output text | while read -r KEY VER
  do
    aws s3api delete-object --bucket "${1}" --key "${KEY}" --version-id "${VER}"
  done
}

# ------------------ Environment Variable ---------------------
# Here defines environment variables except it is generally defined on .zshenv.
# Example : Environment variable of application installed by rtx.


# ------------------ Work -----------------
if [[ -e "${HOME}/.zshrc_work" ]]; then
  source "${HOME}/.zshrc_work"
fi

# ------------------- Starship ------------
eval "$(starship init zsh)"
