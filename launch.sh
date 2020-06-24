#!/usr/bin/env sh

# All purpose launch script

case $1 in
    --devour)
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
            application/zip)
                unzip "$*" -d "${1%.*}"
                ;;
        esac
        ;;
    --choose)
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
