# Path to your oh-my-zsh installation.
export ZSH="/Users/rick/.oh-my-zsh"

# zsh theme: https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# omz plugins
plugins=(tmux git)

# Open tmux on startup, requires tmux plugin
ZSH_TMUX_AUTOSTART=true

# oh-my-zsh.sh sources all the *.zsh files in $ZSH_CUSTOM/custom
# - I include: aliases.zsh, functions.zsh, prompt.zsh, ect.
source $ZSH/oh-my-zsh.sh

# prompt.zsh augments agnoster prompt, removes user@hostname
# needs to be run at end of .zshrc
. ${ZSH_CUSTOM}/prompt.zsh
