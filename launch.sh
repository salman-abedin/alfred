#!/usr/bin/env sh

# All purpose launch script

run() { "$@" > /dev/null 2>&1 & }

case $1 in
    --choose | -c)
        shift
        choice=$(printf "📖 Foxit Reader\n📚 Master PDF Editor\n💻 Code\n🎥 MPV" |
            rofi -dmenu -i -p "Open with" | sed "s/\W//g")
        [ ! "$choice" ] && exit
        case "$choice" in
            FoxitReader) foxitreader "$*" ;;
            MasterPDFEditor) masterpdfeditor4 "$*" ;;
            Code) code "$*" ;;
            MPV) mpv --shuffle "$*" ;;
        esac
        ;;
    --link | -l)
        shift
        case "$1" in
            *mkv | *webm | *mp4 | *mp3 | *youtube.com/watch* | *youtube.com/playlist* | *youtu.be*)
                qmedia "$1"
                ;;
            *)
                run firefox "$1"
                # setsid -f firefox "$1" > /dev/null 2>&1
                ;;
        esac
        ;;
    --tmux | -t)
        if ! pidof tmux; then
            tmux new-session -d -n 'news&mail' 'newsboat' \; \
                split-window -h 'neomutt' \; \
                swap-pane -d -t :.1 \; \
                select-layout main-vertical
            "$TERMINAL" -e tmux attach &
        fi
        ;;
    --terminal | -T)
        $0 -t
        if pidof tmux; then
            tmux new-window
        else
            tmux new-session -d \; switch-client
        fi
        if pidof "$TERMINAL"; then
            [ "$(pidof "$TERMINAL")" != "$(xdo pid)" ] &&
                xdo activate -N Alacritty
        else
            "$TERMINAL" -e tmux attach &
            # "$TERMINAL"
            # sleep 0.5
            # xdo key_press -k 28
            # xdo key_release -k 28
            # xdo key_press -k 38
            # sleep 0.2
            # xdo key_release -k 38
            # xdo key_press -k 36
            # sleep 0.2
            # xdo key_release -k 36
        fi

        ;;
    *)
        if echo "$*" | grep "\.ar\."; then
            alacritty \
                --config-file ~/.config/alacritty/alacritty_ar.yml \
                -e "$EDITOR" "$*" &
            exit
        elif echo "$*" | grep "\.sent$"; then
            sent "$*" &
            exit
        fi
        case $(file --mime-type "$*" -bL) in
            text/* | inode/x-empty | application/json | application/octet-stream)
                $EDITOR "$*"
                ;;
            inode/directory)
                explore "$*"
                ;;
            video/* | audio/* | image/gif)
                qmedia "$1"
                # testt mpv "$*"
                ;;
            application/pdf | application/postscript)
                pidof zathura || run zathura "$*"
                # devour zathura "$*"
                ;;
            image/*)
                pidof feh ||
                    feh -A 'setdisplay --bg %f' -B 'black' \
                        -F -d --edit --keep-zoom-vp --start-at \
                        "$*"
                ;;
            application/*)
                extract --clean "$*"
                ;;
        esac
        ;;
esac
