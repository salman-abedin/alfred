#!/usr/bin/env sh

# Extracts Files based on their extensions
# 'extract --clean' cleans up the archive after extraction

[ "$1" = --clean ] && shift && clean=true
ext="${1##*.}"

case $ext in
    zip) unzip "$1" -d "${1%.*}" ;;
    tar) tar -xf "$1" -C "${1%.*}" ;;
    xz) unxz "$1" -C "${1%.*}" ;;
    gz) tar -xzf "$1" -C "${1%.*}" ;;
    rar) unrar "$1" ;;
    7z) 7z x "$1" ;;
    *) exit 1 ;;
        # tar) tar -xvf "$1" ;;
        # gz) gunzip "$1" ;;
        # zip) unzip "$path" -d "${1%.*}" ;;
esac

[ "$clean" ] && mv -f "$1" ~/.local/Trash
# [ "$clean" ] && rm -f "$1"
