# Defines environment variables.

# Dotfiles
export DOTFILES_DIR="$HOME/Git/dotfiles"

# Log4j
export JAVA_TOOL_OPTIONS="-Dlog4j2.formatMsgNoLookups=true"

# WSL
if [[ "$(uname -r)" == *microsoft* ]]; then
  export PATH=$PATH:$HOME/.windows_commands
fi
