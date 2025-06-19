# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# ----------------- Application ---------------------
# General
source ~/.profile
setopt nonomatch    # No deployment blob

# Execute "ls" after "cd"
chpwd() {ls}

# mise
echo 'eval "$(~/.local/bin/mise activate zsh)"'

# ----------------- Alias ---------------------

# alies Config
alias ls='ls -FG'

# Git Operation
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gph='git push -u origin HEAD'
alias gpfh='git push -u -f origin HEAD'
alias gdf='git diff'
alias gdfs='git diff --staged --stat'

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
autoload -Uz compinit && compinit -C
complete -C '$(which aws_completer)' aws

# ----------------- Function ---------------------

alias assume-role='function _assume_role() {
  profile="$1"

  if [ -z "$profile" ]; then
    echo "\033[31m[ERROR] Specify profile name defined in config file.\033[0m"
    return 1
  fi

  source_profile=$(aws configure get source_profile --profile "$profile")
  role_arn=$(aws configure get role_arn --profile "$profile")

  if [ -z "$source_profile" ] || [ -z "$role_arn" ]; then
    echo "\033[31m[ERROR] Incomplete config file. Can not find source_profile or role_arn in config file.\033[0m"
    return 1
  fi

  session_name="${profile}-$(date +%Y%m%d%H%M%S)"

  creds=$(aws sts assume-role \
    --profile "$source_profile" \
    --role-arn "$role_arn" \
    --role-session-name "$session_name" \
    --query "Credentials" \
    --output json 2>/dev/null)

  if [ $? -ne 0 ] || [ -z "$creds" ]; then
    echo "\033[31m[ERROR] Failed assume-role. Please check aws credential and permission to execute sts assume-role.\033[0m"
    return 1
  fi

  export AWS_ACCESS_KEY_ID=$(echo $creds | jq -r .AccessKeyId)
  export AWS_SECRET_ACCESS_KEY=$(echo $creds | jq -r .SecretAccessKey)
  export AWS_SESSION_TOKEN=$(echo $creds | jq -r .SessionToken)

  echo "\033[32m[SUCCESS] Assumed role $profile with session name $session_name\033[0m"
  
  session_info=$(aws sts get-caller-identity --output json 2>/dev/null)
  if [ $? -eq 0 ] && [ -n "$session_info" ]; then
    echo "\033[32m[SESSION INFO]\033[0m"
    echo "$session_info" | jq .
  else
    echo "\033[31m[ERROR] Failed execute aws sts get-caller-identity\033[0m"
  fi
}; _assume_role'

alias assume-logout='function _assume_logout() {
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN

  echo "\033[32m[SUCCESS] AWS credentials have been cleared.\033[0m"
  echo "\033[34m[INFO] Checking current AWS caller identity...\033[0m"
  identity=$(aws sts get-caller-identity --output json 2>/dev/null)

  if [ $? -eq 0 ]; then
    echo "\033[32m[SUCCESS] Current caller identity after logout:\033[0m"
    echo "$identity" | jq
  else
    echo "\033[31m[ERROR] No valid AWS session after logout. (as expected if no default credentials)\033[0m"
  fi
}; _assume_logout'


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

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
