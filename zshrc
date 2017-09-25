# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
else
  source ~/.zplug/init.zsh
fi

zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "mafredri/zsh-async", from:github
zplug "denysdovhan/spaceship-zsh-theme", as:theme

# zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/git-extras", from:oh-my-zsh
# zplug "plugins/osx", from:oh-my-zsh
# zplug "plugins/brew", from:oh-my-zsh
# zplug "plugins/nvm", from:oh-my-zsh
# zplug "plugins//gitnpm", from:oh-my-zsh
# zplug "zsh-users/zsh-syntax-highlighting", as:plugin
# zplug "l4u/zsh-output-highlighting", as:plugin

# zplug "zsh-users/zsh-syntax-highlighting", defer:2


zplug "~/.zsh", from:local

if zplug check || zplug install; then
  zplug load --verbose
fi

fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept

#
# lscolors
#
autoload -U colors && colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"
export TIME_STYLE="+%y%m%d"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# eval "$(docker-machine env default)"

bindkey -v      # vi mode
vim_ins_mode="%{$fg[yellow]%}[INS]%{$reset_color%}"
vim_cmd_mode="%{$fg[cyan]%}[CMD]%{$reset_color%}"
vim_mode=$vim_ins_mode

function zle-keymap-select {
    vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
    zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
    vim_mode=$vim_ins_mode
}
zle -N zle-line-finish
