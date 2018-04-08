if [[ -v ZSH_PROF ]]; then
  zmodload zsh/zprof
fi

export ZSH=/Users/taylorthurlow/.oh-my-zsh
ZSH_THEME="panda"

DISABLE_UPDATE_PROMPT=true

plugins=(gitfast gpg-agent autojump bundler common-aliases ruby sublime sudo systemd)

source $ZSH/oh-my-zsh.sh

#################################
## USER CONFIG BELOW THIS LINE ##
#################################

# Up a directory with "up"
up() {
    cd $(eval printf '../'%.0s {1..$1})
}

# Makedir and cd into it
mkcd() {
    if [ $# != 1 ]; then
        echo "Usage: mkcd <dir>"
    else
        mkdir -p $1 && cd $1
    fi
}

# make git tab completion faster
__git_files () {
	_wanted files expl 'local files' _files
}

alias naslan="ssh taylor@nas"
alias naswan="ssh taylor@taylorjthurlow.com"

alias rakeprofile="TESTOPTS='--profile' rake test"

alias git=hub

eval "$(rbenv init -)"

# Add postgresql to path
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"

# ELK path stuff
export PATH="/usr/local/opt/elasticsearch@5.6/bin:$PATH"
export PATH="/usr/local/opt/kibana@5.6/bin:$PATH"

# RUST path stuff
export PATH="$HOME/.cargo/bin:$PATH"

# added by travis gem
[ -f /Users/taylorthurlow/.travis/travis.sh ] && source /Users/taylorthurlow/.travis/travis.sh
