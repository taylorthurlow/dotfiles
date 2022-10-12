export PATH="/usr/local/sbin:$PATH"

# Homebrew
export HOMEBREW_NO_INSTALL_CLEANUP=true
export HOMEBREW_AUTOREMOVE=true
export HOMEBREW_BAT=true
export HOMEBREW_BOOTSNAP=true

# Ruby
export PATH="/usr/local/opt/openssl@3/bin:$PATH"
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/opt/openssl@3/lib/"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@3"
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
