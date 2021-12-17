# Home brew
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)"
export JAVA_TOOLS_OPTIONS="-Dlog4j2.formatMsgNoLookups=true"
