#!/usr/bin/env sh

LAST_PATH=~/.local/share/LF_LAST_PATH
if [ "$*" ]; then
    lf -last-dir-path $LAST_PATH "$*"
else
    lf -last-dir-path $LAST_PATH "$(cat $LAST_PATH)"
fi
