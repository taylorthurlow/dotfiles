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

# brew install with fzf
function brew_install_fzf() {
	local inst=$(brew search | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[brew:install]'")

	if [[ $inst ]]; then
		for prog in $(echo $inst)
		do brew install $prog
		done
	fi
}

# checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
function fbr() {
	local branches branch
	branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
	branch=$(echo "$branches" |
			 fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
	git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
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

# Given a filename, look in the current directory and all directories above it
# for a given file. Will print the path of the directory containing the file if
# found, and will return 1 if not found.
function search_upwards() {
	local look=${PWD%/}

	while [[ -n $look ]]; do
		[[ -e $look/$1 ]] && {
			printf '%s\n' "$look"
			return
		}

		look=${look%/*}
	done

	[[ -e /$1 ]] && echo /
}

# Get the current Ruby version based on .ruby-version files.
function current_ruby() {
	if search_result=$(search_upwards .ruby-version); then
		\cat "$search_result/.ruby-version"
	else
		return 1
	fi
}

# Select a docker container to start and attach to
function da() {
	local cid
	cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

	[ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}

# Select a running docker container to stop
function ds() {
	local cid
	cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

	[ -n "$cid" ] && docker stop "$cid"
}

# find in zsh history
function fh() {
	print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | gsed -r 's/ *[0-9]*\*? *//' | gsed -r 's/\\/\\\\/g')
}

function dsa() {
	docker stop $(docker ps -a -q)
}

function bay-clone() {
	git clone git@bitbucket.org:bayphotolab/$1.git
}

function precmd() {
	if val=$(current_ruby); then
		iterm2_set_user_var currentRuby "ruby $val"
	else
		iterm2_set_user_var currentRuby ""
	fi

	if val=$(git branch 2> /dev/null | grep \* | cut -c3-); then
		iterm2_set_user_var gitBranch "$val"
	else
		iterm2_set_user_var gitBranch ""
	fi
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
[ "$(command -v nvim)" ] && alias vim="nvim"
[ "$(command -v thefuck)" ] && eval $(thefuck --alias)

[ -f /Users/taylor/.travis/travis.sh ] && source /Users/taylor/.travis/travis.sh

alias kp="kill_process"
alias bip="brew_install_fzf"
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
alias work="nohup kitty --session ~/.dotfiles/work-kitty &"
alias rake="noglob rake"
alias notes="nvim ~/.notes/main.md"
alias worknotes="nvim ~/.notes/work.md"

unalias fd

alias unraid="ssh root@unraid.local"
alias whatbox="ssh frizkie@apollo.whatbox.ca"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

