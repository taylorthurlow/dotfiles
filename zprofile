# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_INSTALL_CLEANUP=true
export HOMEBREW_AUTOREMOVE=true
export HOMEBREW_BAT=true
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=true
export HOMEBREW_BOOTSNAP=true

# Ruby
export DISABLE_SPRING=1
local openssl_ver_num=3
export PATH="/opt/homebrew/opt/openssl@$openssl_ver_num/bin:$PATH"
export LIBRARY_PATH="$LIBRARY_PATH:/opt/homebrew/opt/openssl@$openssl_ver_num/lib/"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/opt/homebrew/opt/openssl@$openssl_ver_num"
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:"/opt/homebrew/opt/openssl@$openssl_ver_num/lib/pkgconfig"

# Miscellaneous
export PATH="$PATH:/Users/taylorthurlow/.cargo/bin"
export PATH="$HOME/.anyenv/bin:$PATH"
[ "$(command -v kubectl)" ] && export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/svkube"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Specific versioned homebrew packages
export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"
export PATH="/opt/homebrew/opt/imagemagick@6/bin:$PATH"
