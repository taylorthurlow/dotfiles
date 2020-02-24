if [[ $UID -eq 0 ]]; then
    local user_symbol='#'
else
    local user_symbol='$'
fi

local current_dir='%{$fg[blue]%}%2/%{$reset_color%}'

PROMPT="${current_dir} %B${user_symbol}%b> "

# Right side
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

RPS1="%B${return_code}%b"
