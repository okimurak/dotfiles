# Defines environment variables.

# Log4j
export JAVA_TOOLS_OPTIONS="-Dlog4j2.formatMsgNoLookups=true"

# WSL
if [[ "$(uname -r)" == *microsoft* ]]; then
  export PATH=$PATH:$HOME/.windows_commands
fi
