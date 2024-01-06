# PROMPT='%1~/ %# '
PROMPT='%F{33}t%f%F{39}a%f%F{38}y%f%F{44}lor%f%F{50}@%f%F{43}cin%f%F{44}tra%f%F{38}:%1~/%f %F{44}%#%f '

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
source /opt/homebrew/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Autosuggestions
source /opt/homebrew/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^n' autosuggest-accept
bindkey '^ ' autosuggest-execute

# Prompt navigation
bindkey "^[[H" beginning-of-line # Home
bindkey "^[[F" end-of-line       # End
bindkey "^[[5~" backward-word    # Page Up
bindkey "^[[6~" forward-word     # Page Down

function dev() {
	if [ -n "$1" ]; then
		destination=$(zoxide query "$1")

		# If zoxide call failed, return same error code
		if [ $? -ne 0 ]; then
			return $?
		fi

		zellij action new-tab --name "$(basename "$destination")" --layout ~/.config/zellij/dev.kdl --cwd "$destination"

		# If zellij call failed, return same error code
		if [ $? -ne 0 ]; then
			return $?
		fi

		# cd -
	else
		zellij action new-tab --name "$(basename "$destination")" --layout ~/.config/zellij/dev.kdl --cwd "."
	fi
}

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

# git interactive rebase with fzf commit selection
function girb() {
	if [ "$(command -v thicket)" ]; then
		git rebase -i $(thicket --color-prefixes --refs --initials | fzf --ansi | tr -cd "[:alnum:] " | cut -w -f2)^
	else
		git rebase -i $(git log --decorate --oneline --color=always | fzf --ansi | cut -d ' ' -f1 )^
	fi

}

function bay-clone() {
	git clone git@bitbucket.org:bayphotolab/$1.git
}

function plex-loudness() {
  ssh -t -o LogLevel=QUIET root@unraid.local \
		"docker exec -itu abc plex bash -c '/lib/plexmediaserver/Plex\ Media\ Scanner --force --analyze-loudness --loudness-parallelism 6 --item $@'"
}

function nlp-timestamp-copy() {
  exiftool "-TimeCreated<DigitalCreationTime" "-DateCreated<DateTimeOriginal" $@
}

export GPG_TTY=$(tty)
if [[ -n "$SSH_CONNECTION" ]]; then
	export PINENTRY_USER_DATA="USE_CURSES=1"
fi

[ "$(command -v nvim)" ] && export EDITOR="$(which nvim)"
[ "$(command -v bat)" ] && alias cat="bat"
[ "$(command -v eza)" ] && alias ls="eza"

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

# Extra aliases
alias be="bundle exec"
alias bi="bundle install"
alias biy="bundle install && bundle exec yard gems -q"
alias bu="bundle update"
alias bout="bundle outdated --only-explicit"
alias dc="docker-compose"
alias gfap="git fetch --all --prune"
alias glog="thicket --color-prefixes --refs --initials --exclude-remote-dependabot | less"
alias gloga="thicket --color-prefixes --all --refs --initials --exclude-remote-dependabot | less"
alias wglog="watch -t -c -n 1 thicket --color-prefixes -n 200 --refs --initials --exclude-remote-dependabot"
alias wgloga="watch -t -c -n 1 thicket --color-prefixes -n 200 --refs --all --initials --exclude-remote-dependabot"
alias kp="kill_process"
alias lg="lazygit"
alias notes="nvim ~/.notes/main.md"
alias worknotes="nvim ~/.notes/work.md"
alias xit="exit"

alias zshrc="nvim ~/.zshrc"
alias zprofile="nvim ~/.zprofile"

# We want PATH modification to happen even in non-interactive shells, so we'll
# include all the PATH modification in ~/.zprofile. Do not add PATH modification
# to this file.

# Google Cloud SDK
if [ "$(command -v gcloud)" ]; then
	source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
	source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi

# iTerm Shell Integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# bun completions
[ -s "/Users/taylor/.bun/_bun" ] && source "/Users/taylor/.bun/_bun"

