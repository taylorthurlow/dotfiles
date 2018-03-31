# The prompt
PROMPT='%{$fg[cyan]%}%2~ %{$fg[yellow]%}$(_user_host)%{$reset_color%}> '

function _user_host() {if [[ -n $SSH_CONNECTION ]]; then
    me="%n@%m"
  elif [[ $LOGNAME != $USER ]]; then
    me="%n"
  fi
  if [[ -n $me ]]; then
    echo "%{$fg[cyan]%}$me%{$reset_color%}:"
  fi
}
