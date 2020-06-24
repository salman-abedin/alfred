#!/usr/bin/env sh

# Launch-devour: The XDG Killer with Devouring feature
# Launches files based on their mimetype
# Usage: launch-devour [FILE...]

case $(file --mime-type "$*" -bL) in
    # Check for the mimetype of your file
    text/* | inode/x-empty | application/json | application/octet-stream)
        # Launch using your favorite application
        "$EDITOR" "$*"
        ;;
    video/*)
        devour mpv "$*"
        ;;
    application/pdf | application/postscript)
        devour zathura "$*"
        ;;
    image/gif)
        devour mpv --loop "$*"
        ;;
    image/*)
        devour \
            feh -A 'alfred --bg %f' -B 'black' -F -d --edit --keep-zoom-vp --start-at "$*"
        ;;
    application/zip)
        unzip "$*" -d "${1%.*}"
        ;;
esac
