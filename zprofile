# PATH modification
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.anyenv/bin:$PATH"

# Other stuff
[ "$(command -v anyenv)" ] && eval "$(anyenv init -)"
