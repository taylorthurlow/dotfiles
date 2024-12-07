# Host-specific configuration may be installed by RCM. May set some environment
# variables to be used in this file.
if [ -f ~/.zshrc.local ]; then source ~/.zshrc.local; fi

# Ctrl-D in sequence to exit
autoload -Uz add-zle-hook-widget
export IGNOREEOF=3

KEYTIMEOUT=1

# Disable "implied cd" when using a path as a command
unsetopt AUTOcd

# Disable "flow control" with CTRL-S and CTRL-Q, not seeing if iTerm supports
# this but it's here just in case
setopt noflowcontrol

# History configuration, avoid duplicates in logs/history recall
HISTFILE=50000
HISTFILE=~/.zsh_history
SAVEHIST=50000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Case-insensitive completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Prompt syntax highlighting
source $HOMEBREW_PREFIX/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Autosuggestions
source $HOMEBREW_PREFIX/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^n' autosuggest-accept
bindkey '^ ' autosuggest-execute

# Prompt navigation
bindkey "^[[H" beginning-of-line    # Home
bindkey "^[[F" end-of-line          # End
bindkey "^[[5~" backward-word       # Page Up
bindkey "^[[6~" forward-word        # Page Down
bindkey "^[[1;5D" backward-word     # Ctrl + Left
bindkey "^[[1;5C" forward-word      # Ctrl + Right
bindkey "^[[1;5A" beginning-of-line # Ctrl + Up
bindkey "^[[1;5B" end-of-line       # Ctrl + Down
bindkey "^[[1;3D" backward-word     # Alt + Left
bindkey "^[[1;3C" forward-word      # Alt + Right
bindkey "^[[1;3A" beginning-of-line # Alt + Up
bindkey "^[[1;3B" end-of-line       # Alt + Down

# Prompt history search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

if [ "$(command -v zellij)" ]; then
	function dev() {
		if [ -n "$1" ]; then
			destination=$(zoxide query "$1")

			# If zoxide call failed, return same error code
			if [ $? -ne 0 ]; then
				return $?
			fi

			zellij action new-tab --name "$(basename "$destination")" --layout default --cwd "$destination"

			# If zellij call failed, return same error code
			if [ $? -ne 0 ]; then
				return $?
			fi

			# cd -
		else
			zellij action new-tab --name "$(basename "$destination")" --layout default --cwd "."
		fi
	}
fi

# Makedir and cd into it
function mkcd() {
	if [ $# != 1 ]; then
		echo "Usage: mkcd <dir>"
	else
		mkdir -p $1 && cd $1
	fi
}

# Delete local and remote branches
function git-nuke {
	echo "ARE YOU SURE you want to nuke $1?"
	select yn in "Yes" "No"; do
	    case $yn in
		Yes ) git branch -D $1 && git push origin :$1; break;;
		No ) return;;
	    esac
	done
}

# Use `jq` with both JSON and non-JSON lines.
function jjq {
	jq -R -r "${1:-.} as \$line | try fromjson catch \$line"
}

# make git tab completion faster
function __git_files () {
	_wanted files expl 'local files' _files
}

if [ "$(command -v fzf)" ]; then
	# easy kill processes
	alias kp="kill_process"
	function kill_process() {
		local pid=$(ps -ef | sed 1d | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[kill:process]'" | awk '{print $2}')

		if [ "x$pid" != "x" ]
		then
			echo $pid | xargs kill -${1:-9}
			kp
		fi
	}
fi

function bay-clone() {
	git clone git@bitbucket.org:bayphotolab/$1.git
}

function nlp-timestamp-copy() {
	exiftool "-TimeCreated<DigitalCreationTime" "-DateCreated<DateTimeOriginal" $@
}

# Emulate Bash $IGNOREEOF behavior
setopt ignore_eof
function bash-ctrl-d() {
	if [[ $CURSOR == 0 && -z $BUFFER ]]; then
		[[ -z $IGNOREEOF || $IGNOREEOF == 0 ]] && exit

		if [[ "$LASTWIDGET" == "bash-ctrl-d" ]]; then
			(( --__BASH_IGNORE_EOF <= 0 )) && exit
		else
			(( __BASH_IGNORE_EOF = IGNOREEOF-1 ))
			echo
		fi

		echo "Press Ctrl-D $__BASH_IGNORE_EOF more time(s) to exit."
	fi
}

zle -N bash-ctrl-d
bindkey '^D' bash-ctrl-d

export GPG_TTY=$(tty)
if [[ -n "$SSH_CONNECTION" ]]; then
	export PINENTRY_USER_DATA="USE_CURSES=1"
fi

[ "$(command -v nvim)" ] && export EDITOR="$(which nvim)"
[ "$(command -v bat)" ] && alias cat="bat"
[ "$(command -v eza)" ] && alias ls="eza"
[ "$(command -v zed-preview)" ] && alias zed="zed-preview"

[ "$(command -v lazygit)" ] && function lg() {
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ $? -eq 0 ] && [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

if [ "$(command -v hub)" ]; then
	alias git="hub"
	alias gci="hub ci-status -v"
fi

if [ "$(command -v kubectl)" ]; then
	alias kctl="kubectl"
	source <(kubectl completion zsh)
fi

if [ "$(command -v zoxide)" ]; then
	eval "$(zoxide init zsh)"
	alias cd="z"
	alias cdi="zi"
fi

# Built-in aliases
alias ll="ls -l"
alias ldot="ls -ld .*"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias grep="grep --color=auto"

# Git aliases
alias gst="git status"
alias gp="git push"
alias gpr="git pull --rebase"
alias gfap="git fetch --all --prune"
alias gsw="git switch"
alias gre="git restore"

log_command="git log --color=always --graph --date=short --pretty='format:%C(yellow)%h%Creset%C(auto)%(decorate:tag=)%Creset %s %C(cyan)[%aN]%Creset %Cgreen(%ad, %ar)%Creset'"

function glog() {
	eval "GIT_PAGER=\"less -SR\" $log_command $@"
}

function gloga() {
	eval "GIT_PAGER=\"less -SR\" $log_command --perl-regexp --exclude='refs/remotes/*/dependabot*' --all $@"
}

function wglog() {
	watch --no-wrap --no-title --color --interval 1 -- "$log_command $@"
}

function wgloga() {
	watch --no-wrap --no-title --color --interval 1 -- "$log_command --exclude='refs/remotes/*/dependabot*' --all $@"
}

function girb() {
	eval "git rebase -i $(glog | fzf --ansi | cut -d ' ' -f2)^"
}

# Extra aliases
alias be="bundle exec"
alias bi="bundle install"
alias biy="bundle install && bundle exec yard gems -q"
alias bu="bundle update"
alias bout="bundle outdated --only-explicit"
alias dc="docker-compose"
alias notes="nvim ~/.notes/main.md"
alias worknotes="nvim ~/.notes/work.md"
alias xit="exit"
alias imgcat="wezterm imgcat"

alias zshrc="nvim ~/.zshrc"
alias zprofile="nvim ~/.zprofile"

# We want PATH modification to happen even in non-interactive shells, so we'll
# include all the PATH modification in ~/.zprofile. Do not add PATH modification
# to this file.

[ "$(command -v rbenv)" ] && eval "$(rbenv init -)"
[ "$(command -v nodenv)" ] && eval "$(nodenv init -)"

# Google Cloud SDK
if [ "$(command -v gcloud)" ]; then
	source $HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
	source $HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi

# iTerm Shell Integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
