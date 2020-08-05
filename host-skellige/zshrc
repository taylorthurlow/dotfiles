export ZSH=/Users/taylor/.oh-my-zsh
ZSH_THEME="panda"
plugins=(git autojump common-aliases ruby sudo)
DISABLE_UPDATE_PROMPT=true
KEYTIMEOUT=1

source $ZSH/oh-my-zsh.sh

source "$HOME/.dotfiles/zshrc_shared"

#################################
## USER CONFIG BELOW THIS LINE ##
#################################

# ZSH Prompt Coolness
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Google Cloud SDK
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

# iTerm Shell Integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

