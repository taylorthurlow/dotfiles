# PATH modification
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.anyenv/bin:$PATH"

# Homebrew
HOMEBREW_NO_INSTALL_CLEANUP=true
HOMEBREW_AUTOREMOVE=true
HOMEBREW_BAT=true
HOMEBREW_BOOTSNAP=true

# Ruby
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl)"
export DISABLE_SPRING=1

# Crystal compilation
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:"/usr/local/opt/openssl/lib/pkgconfig"

# Other stuff
export PATH="$PATH:/Users/taylorthurlow/.cargo/bin"
[ "$(command -v anyenv)" ] && eval "$(anyenv init -)"

# Specific versioned homebrew packages
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PATH="/usr/local/opt/node@12/bin:$PATH"
export PATH="/usr/local/opt/v8@3.15/bin:$PATH"
