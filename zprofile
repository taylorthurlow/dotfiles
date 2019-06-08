# PATH modification
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# Other stuff
[ "$(command -v anyenv)" ] && eval "$(anyenv init -)"
