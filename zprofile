export HOMEBREW_NO_INSTALL_CLEANUP=true
export HOMEBREW_AUTOREMOVE=true
export HOMEBREW_BAT=true
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=true
export HOMEBREW_BOOTSNAP=true

# Host-specific configuration may be installed by RCM. May set some environment
# variables to be used in this file.
if [ -f ~/.zprofile.local ]; then source ~/.zprofile.local; fi

# Ruby
OPENSSL_VER_NUM="${OPENSSL_VER_NUM:-3}"
export DISABLE_SPRING=1
export PATH="$HOMEBREW_PREFIX/opt/openssl@$OPENSSL_VER_NUM/bin:$PATH"
export LIBRARY_PATH="$LIBRARY_PATH:$HOMEBREW_PREFIX/opt/openssl@$OPENSSL_VER_NUM/lib/"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$HOMEBREW_PREFIX/opt/openssl@$OPENSSL_VER_NUM"
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:"$HOMEBREW_PREFIX/opt/openssl@$OPENSSL_VER_NUM/lib/pkgconfig"
export RUBYOPT="--backtrace-limit=5"

# Miscellaneous
export PATH="$PATH:/Users/taylorthurlow/.cargo/bin"
export PATH="$HOME/.anyenv/bin:$PATH"
[ "$(command -v kubectl)" ] && export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/svkube"

# Specific versioned homebrew packages
export PATH="$HOMEBREW_PREFIX/opt/mysql@5.7/bin:$PATH"
export PATH="$HOMEBREW_PREFIX/opt/imagemagick@6/bin:$PATH"
