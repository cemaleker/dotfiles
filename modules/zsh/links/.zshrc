export DOTF=~/.dotfiles
export DOTF_ZSH=$DOTF/modules/zsh

files=( $DOTF_ZSH/autoload/*(N) )

if (( $#files )); then
  for file in $DOTF_ZSH/autoload/*.zsh; do
    source $file
  done
fi

