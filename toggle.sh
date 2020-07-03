#!/usr/bin/env sh

# Toggles Wifi, Notification & Wallpaper reeling
# toggle --[noti,wifi,wall-reel]

while :; do
    case $1 in
        --wall-reel | -r)
            REELPID=/tmp/reelpid
            if [ -s $REELPID ]; then
                kill -9 "$(cat $REELPID)"
                : > $REELPID
                notify-send -u low -i "$ICONS"/wall.png "Wallpaper Reeling Stopped"
            else
                notify-send -u low -i "$ICONS"/wall.png "Wallpaper Reeling Started"
                while :; do
                    setdisplay --bg shuffle
                    sleep 5m
                done &
                echo $! > $REELPID
            fi
            ;;
        --noti | -n)
            if [ -s "$DDM" ]; then
                : > "$DDM"
                killall -SIGUSR2 dunst
                sleep 1
                notify-send -u low -i "$ICONS"/bell.png 'Disturb all you want'
            else
                echo on > "$DDM"
                notify-send -u low -i "$ICONS"/dnd.png 'Do not disturb'
                sleep 2
                killall -SIGUSR1 dunst
            fi
            uniblocks -u noti
            ;;
        --wifi | -w)
            if pidof iwd; then
                doas systemctl stop iwd
                notify-send -u low -i "$ICONS"/disconnected.png 'Turned Wifi Off'
            else
                doas systemctl start iwd
                notify-send -u low -i "$ICONS"/connected.png 'Turned Wifi On'
            fi
            ;;
        --focus | -f)
            if [ -s "$DDM" ]; then
                xdo show -a "$STATUSBAR"
                bspc config top_padding 35
            else
                xdo hide -a "$STATUSBAR"
                bspc config top_padding 0
            fi
            tmux set status
            $0 -r -w -n
            ;;
        *) break ;;
    esac
    shift
done
