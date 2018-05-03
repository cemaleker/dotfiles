export CASE_SENSITIVE=0
export EDITOR="mvim -v"
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
zplug "lib/clipboard",	 from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
zplug "plugins/git",   from:oh-my-zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi


zplug load --verbose


alias gpg="LANG=en gpg"

