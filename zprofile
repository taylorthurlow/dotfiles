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
export DISABLE_SPRING=1

# Specific versioned homebrew packages
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PATH="/usr/local/opt/node@12/bin:$PATH"
export PATH="/usr/local/opt/v8@3.15/bin:$PATH"
