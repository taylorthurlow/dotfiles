export HOMEBREW_NO_INSTALL_CLEANUP=true
export HOMEBREW_AUTOREMOVE=true
export HOMEBREW_BAT=true
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=true
export HOMEBREW_BOOTSNAP=true

export LC_COLLATE=C

export XDG_CONFIG_HOME="/Users/taylor/.config"

# Host-specific configuration may be installed by RCM. May set some environment
# variables to be used in this file.
if [ -f ~/.zprofile.local ]; then source ~/.zprofile.local; fi

# Ruby
export RUBY_DEBUG_IRB_CONSOLE=1
OPENSSL_VER_NUM="${OPENSSL_VER_NUM:-3}"
export DISABLE_SPRING=1
export PATH="$HOMEBREW_PREFIX/opt/openssl@$OPENSSL_VER_NUM/bin:$PATH"
export LIBRARY_PATH="$LIBRARY_PATH:$HOMEBREW_PREFIX/opt/openssl@$OPENSSL_VER_NUM/lib/"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$HOMEBREW_PREFIX/opt/openssl@$OPENSSL_VER_NUM"
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:"$HOMEBREW_PREFIX/opt/openssl@$OPENSSL_VER_NUM/lib/pkgconfig"

# Miscellaneous
export PATH="$PATH:/Users/taylorthurlow/.cargo/bin"
export PATH="$PATH:$HOMEBREW_PREFIX/opt/rustup/bin"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.nodenv/bin:$PATH"
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
[ "$(command -v kubectl)" ] && export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/svkube"
export LESS="-R"

# Specific versioned homebrew packages
export PATH="$HOMEBREW_PREFIX/opt/imagemagick@6/bin:$PATH"
