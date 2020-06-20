# PATH modification
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.anyenv/bin:$PATH"

# Ruby compilation
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl)"

# Crystal compilation
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:"/usr/local/opt/openssl/lib/pkgconfig"

# Other stuff
export PATH="$PATH:/Users/taylorthurlow/.cargo/bin"
[ "$(command -v anyenv)" ] && eval "$(anyenv init -)"
