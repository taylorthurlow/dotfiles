# PATH modification
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.anyenv/bin:$PATH"

# Ruby compilation
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl)"

# Other stuff
[ "$(command -v anyenv)" ] && eval "$(anyenv init -)"
