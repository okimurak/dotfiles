# brew
OS="$(uname)"
if [[ "${OS}" == "Darwin" ]]; then
  # https://raw.githubusercontent.com/Home
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  # Read homebrew https://docs.brew.sh/Homebrew-on-Linux#install
  test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
  test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

# mise
eval "$(mise activate zsh --shims)"
