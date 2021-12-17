# Read homebrew https://docs.brew.sh/Homebrew-on-Linux#install
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
eval $($(brew --prefix)/bin/brew shellenv)

# Configure Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export JAVA_TOOLS_OPTIONS="-DLog4j2.formatMsgNoLookups=true"
