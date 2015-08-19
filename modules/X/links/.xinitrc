#!/bin/zsh

export DOTF_X=$DOTF/modules/X
export XDG_CONFIG_HOME=$HOME/.config

files=( $DOTF_X/initrc/autoload/*(N) )
if (( $#files )); then
    for f in $files; do
        source "${f}"
    done
fi

files=( $DOTF_X/modmap/autoload/*(N) )
if (( $#files )); then
    for modmap in $files; do
        xmodmap "${modmap}"
    done
fi

files=( $DOTF_X/resources/autoload/*(N) )
if (( $#files )); then
    for res in $files; do
        xrdb -merge "${res}"
    done
fi

files=( $DOTF_X/pre-wm/autoload/*(N) )
if (( $#files )); then
    for f in $files; do
        source "${f}"
    done
fi

source $DOTF_X/wm

