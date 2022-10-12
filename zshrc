export ZSH=/Users/taylor/.oh-my-zsh
ZSH_THEME="panda"
plugins=(git autojump common-aliases ruby sudo)
DISABLE_UPDATE_PROMPT=true
KEYTIMEOUT=1

source $ZSH/oh-my-zsh.sh

#################################
## USER CONFIG BELOW THIS LINE ##
#################################

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey '^n' autosuggest-accept
bindkey '^ ' autosuggest-execute

# Up a directory with "up"
function up() {
	cd $(eval printf '../'%.0s {1..$1})
}

# Makedir and cd into it
function mkcd() {
	if [ $# != 1 ]; then
		echo "Usage: mkcd <dir>"
	else
		mkdir -p $1 && cd $1
	fi
}

# Makedir and take ownership
function mkchown() {
	if [ $# != 1 ]; then
		echo "Usage: mkchown <dir>"
	else
		sudo mkdir -p $1 && sudo chown $(whoami):$(whoami) $1
	fi
}

# Delete local and remote branches
function git-nuke {
	git branch -D $1 && git push origin :$1
}

# Use `jq` with both JSON and non-JSON lines.
function jjq {
	jq -R -r "${1:-.} as \$line | try fromjson catch \$line"
}

# make git tab completion faster
function __git_files () {
	_wanted files expl 'local files' _files
}

# easy kill processes with fzf
function kill_process() {
	local pid=$(ps -ef | sed 1d | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[kill:process]'" | awk '{print $2}')

	if [ "x$pid" != "x" ]
	then
		echo $pid | xargs kill -${1:-9}
		kp
	fi
}

# autojump when used with no args uses fzf
function j() {
	if [[ "$#" -ne 0 ]]; then
		cd $(autojump $@)
		return
	fi
	cd "$(autojump -s | gsed '/_____/Q; s/^[0-9,.:]*\s*//' | fzf --height 40% --reverse --inline-info)"
}

# git interactive rebase with fzf commit selection
function girb() {
	git rebase -i $(git log --decorate --oneline --color=always | fzf --ansi | cut -d ' ' -f1 )^
}

# find in zsh history
function fh() {
	print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | gsed -r 's/ *[0-9]*\*? *//' | gsed -r 's/\\/\\\\/g')
}

function bay-clone() {
	git clone git@bitbucket.org:bayphotolab/$1.git
}

unsetopt AUTOcd
setopt noflowcontrol

export GPG_TTY=$(tty)
if [[ -n "$SSH_CONNECTION" ]]; then
	export PINENTRY_USER_DATA="USE_CURSES=1"
fi

[ "$(command -v nvim)" ] && export EDITOR="$(which nvim)"
[ "$(command -v bat)" ] && alias cat="bat"
[ "$(command -v hub)" ] && alias git="hub"
[ "$(command -v hub)" ] && alias gci="hub ci-status -v"
[ "$(command -v exa)" ] && alias ls="exa"

alias kp="kill_process"
alias dc="docker-compose"
alias gst="git status -s"
alias bid="bundle install --path=vendor --jobs=$(sysctl -n hw.ncpu) --binstubs=.bundle/bin"
alias bi="bundle install"
alias be="bundle exec"
alias gfap="git fetch --all --prune"
alias gs="git sync"
alias gcane="git commit --amend --no-edit"
alias glog="thicket --color-prefixes --refs --initials | less"
alias gloga="thicket --color-prefixes --all --refs --initials | less"
alias wglog="watch -t -c -n 1 thicket --color-prefixes -n 200 --refs --initials"
alias wgloga="watch -t -c -n 1 thicket --color-prefixes -n 200 --refs --all --initials"
alias xit="exit"
alias notes="nvim ~/.notes/main.md"
alias worknotes="nvim ~/.notes/work.md"

unalias fd

# We want PATH modification to happen even in non-interactive shells, so we'll
# include all the PATH modification in ~/.zprofile. Do not add PATH modification
# to this file.

# ZSH Prompt Coolness
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Google Cloud SDK
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

# iTerm Shell Integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

