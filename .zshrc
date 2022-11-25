# ----------------- Application ---------------------
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Prezto
# Should stay here.
# Bacause the following command has to need except here.
# # Finalize for p10k
# (( ! ${+functions[p10k]} )) || p10k finalize
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# asdf
. $HOME/.asdf/asdf.sh

# General
source ~/.profile
setopt nonomatch    # No deployment blob

# Execute "ls" after "cd"
chpwd() {ls}

# Theme
source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme

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

# ctop(https://github.com/bcicen/ctop)
alias ctop='docker run --rm -ti \
  --name=ctop \
  --volume /var/run/docker.sock:/var/run/docker.sock:ro \
  quay.io/vektorlab/ctop:latest'

# ----------------- Completer ---------------------

fpath=(~/.zsh/completion $fpath)
## append completions to fpath for asdf
fpath=(${ASDF_DIR}/completions $fpath)
autoload -U compinit && compinit -u

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
  BUFFER=`history -n 1 | tac | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# ------------------ Environment Variable ---------------------
# Here defines environment variables except it is generally defined on .zshenv.
# Example : Environment variable of application installed by asdf.

# Go
export GOPATH=$(go env GOPATH)

# ------------------ Work -----------------
source ~/.zshrc_work
