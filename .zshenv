#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# Log4j
export JAVA_TOOLS_OPTIONS="-Dlog4j2.formatMsgNoLookups=true"

# WSL
if [[ "$(uname -r)" == *microsoft* ]]; then
  export PATH=$PATH:$HOME/.windows_commands
fi
