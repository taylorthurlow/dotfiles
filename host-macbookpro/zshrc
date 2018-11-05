if [[ -v ZSH_PROF ]]; then
  zmodload zsh/zprof
fi

export ZSH=/Users/taylorthurlow/.oh-my-zsh
ZSH_THEME="panda"

KEYTIMEOUT=1 # 10ms for key sequences, for vim escape
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

setopt noflowcontrol

alias naslan="ssh taylor@nas.local"
alias naswan="ssh taylor@thurlow.io"
alias rakeprofile="TESTOPTS='--profile' rake test"
alias git=hub
alias gst="hub status -s"
alias glog="git log --oneline --decorate --color --graph --pretty=format:'%C(yellow)%h %Cgreen%ad %Cblue%an%Cred%d %Creset%s' --date=short"
alias brewup="brew update; brew upgrade; brew cask upgrade"
alias brewupup="brewup; brew prune; brew cleanup; brew doctor"
alias linenums="nl -w3 -ba -s ' | '"
alias be="bundle exec"

function git-nuke {
  git branch -D $1 && git push origin :$1
}

# PATH modification
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/sbin:$PATH" # homebrew
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
export PATH="$PATH:/usr/local/opt/elasticsearch@5.6/bin"
export PATH="$PATH:/usr/local/opt/kibana@5.6/bin"
export PATH="$PATH:/usr/local/opt/mysql@5.7/bin"
export PATH="$PATH":/usr/local/anaconda3/bin

eval "$(rbenv init -)"
[ -f /Users/taylorthurlow/.travis/travis.sh ] && source /Users/taylorthurlow/.travis/travis.sh
