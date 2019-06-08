# Modified version of bira theme, comes with oh my zsh
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"


if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%n@%m%{$reset_color%}'
    local user_symbol='#'
else
    local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
    local user_symbol='$'
fi

local current_dir='%{$terminfo[bold]$fg[blue]%}%~%{$reset_color%}'
local rbenv_stuff='$(
  if which rbenv &> /dev/null; then
    if [[ "$(rbenv version)" =~ \/.ruby-version\)$ ]]; then
      echo "$fg[red]Ruby $(rbenv version | sed -e "s/ (set.*$//")$reset_color "
    fi
  fi
)'

local crenv_stuff='$(
  if which crenv &> /dev/null; then
    if [[ "$(crenv version)" =~ \/.crystal-version\)$ ]]; then
      echo "$fg[magenta]Crystal $(crenv version | sed -e "s/ (set.*$//")$reset_color "
    fi
  fi
)'

local git_branch='$(git_prompt_info)%{$reset_color%}'

PROMPT="╭─${user_host} ${current_dir} ${rbenv_stuff}${crenv_stuff}${git_branch}
╰─%B${user_symbol}%b "
RPS1="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

