#!/usr/bin/env sh

last_path=~/.config/lf/last_path

if [ "$*" ]; then
    lf -last-dir-path $last_path "$*" 
else
    lf -last-dir-path $last_path "$(cat $last_path)"
fi

# doas -- lf -last-dir-path ~/.config/lf/lastPath "$(cat ~/.config/lf/lastPath)"
