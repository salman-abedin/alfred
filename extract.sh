#!/usr/bin/env sh

# Extracts Files based on their extensions
# 'extract --clean' cleans up the archive after extraction

[ "$1" = --clean ] && shift && clean=true
path=$(readlink -f "$1")
ext="${path##*.}"
# name="${path%.*}"

case $ext in
    zip) unzip "$path" -d "${1%.*}" ;;
    tar) tar -xvf "$path" ;;
    gzip) gunzip "$path" ;;
    rar) unrar "$path" ;;
esac

[ "$clean" ] && rm -f "$1"
