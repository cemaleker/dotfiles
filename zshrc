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
zplug "l4u/zsh-output-highlighting", from:gh-r, as:plugin

# zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

# zplug "plugins/git", from:oh-my-zsh
# zplug "plugins/git-extras", from:oh-my-zsh
# zplug "plugins/osx", from:oh-my-zsh
zplug "plugins/brew", from:oh-my-zsh
zplug "plugins/nvm", from:oh-my-zsh
zplug "plugins/gitnpm", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2, as:plugin
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

zplug "~/.dotfiles", from:local

bindkey -v      # vi mode
vim_ins_mode="%{$fg[yellow]%}[INS]%{$reset_color%}"
vim_cmd_mode="%{$fg[cyan]%}[CMD]%{$reset_color%}"
vim_mode=$vim_ins_mode

if zplug check || zplug install; then
  zplug load --verbose
fi

fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept
bindkey '^R'   history-incremental-pattern-search-backward

setopt pushd_to_home            # `pushd` = `pushd $HOME`
#
##
# History
##
HISTFILE=~/.zsh_history         # where to store zsh config
HISTSIZE=4048                   # big history
SAVEHIST=4048                   # big history
setopt append_history           # append
setopt hist_ignore_all_dups     # no duplicate
unsetopt hist_ignore_space      # ignore space prefixed commands
setopt hist_reduce_blanks       # trim blanks
setopt hist_verify              # show before executing history commands
setopt inc_append_history       # add commands as they are typed, don't wait until shell exit
setopt share_history            # share hist between sessions
setopt bang_hist                # !keyword

ZSH_THEME="powerlevel9k/powerlevel9k"

#
# lscolors
#
autoload -U colors && colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"
export TIME_STYLE="+%y%m%d"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# eval "$(docker-machine env default)"


function zle-keymap-select {
    vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
    zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
    vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

fpath=(~/.zsh/completion /usr/local/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit -i

[[ -s ~/.profile ]] && source ~/.profile
