export PATH="/usr/local/sbin:$PATH"

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

# Miscellaneous
export PATH="$PATH:/Users/taylorthurlow/.cargo/bin"
export PATH="$HOME/.anyenv/bin:$PATH"
[ "$(command -v anyenv)" ] && eval "$(anyenv init -)"

# Specific versioned homebrew packages
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
