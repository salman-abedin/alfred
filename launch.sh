#!/usr/bin/env sh

# All purpose launch script
# Dependency: Devour

case $1 in
    --devour | -d)
        shift

        if echo "$*" | grep "\.ar\."; then
            devour alacritty \
                --config-file ~/.config/alacritty/alacritty_ar.yml \
                -e "$EDITOR" "$*" &
            exit
        elif echo "$*" | grep "\.sent$"; then
            devour sent "$1" &
            exit
        fi

        case $(file --mime-type "$*" -bL) in
            text/* | inode/x-empty | application/json | application/octet-stream)
                $EDITOR "$*"
                ;;
            video/* | audio/* | image/gif)
                pidof mpv || devour mpv "$*"
                ;;
            application/pdf | application/postscript)
                pidof zathura || devour zathura "$*"
                ;;
            image/*)
                pidof feh ||
                    devour \
                        feh -A 'setdisplay --bg %f' -B 'black' -F -d --edit --keep-zoom-vp --start-at "$*"
                ;;
            application/*)
                extract --clean "$*"
                ;;
        esac
        ;;
    --choose | -c)
        shift
        choice=$(printf "📖 Foxit Reader\n📚 Master PDF Editor\n💻 Code\n🎥 MPV" |
            rofi -dmenu -i -p "Open with" | sed "s/\W//g")
        [ ! "$choice" ] && exit
        case "$choice" in
            FoxitReader) devour foxitreader "$*" ;;
            MasterPDFEditor) devour masterpdfeditor4 "$*" ;;
            Code) devour code "$*" ;;
            MPV) devour mpv --shuffle "$*" ;;
        esac
        ;;
    --link | -l)
        shift
        case "$1" in
            *mkv | *webm | *mp4 | *youtube.com/watch* | *youtube.com/playlist* | *youtu.be*)
                setsid -f mpv "$1" > /dev/null 2>&1
                ;;
            *)
                setsid -f "$BROWSER" "$1" > /dev/null 2>&1
                ;;
        esac
        ;;
    *)
        case $(file --mime-type "$*" -bL) in
            x-scheme-handler/magnet | application/x-bittorrent)
                torrent --add "$*"
                ;;
            application/pdf | application/postscript)
                zathura "$*"
                ;;
        esac
        ;;
esac
