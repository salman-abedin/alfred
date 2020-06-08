#!/usr/bin/env sh

# Panel Module Generator

while :; do
    case $1 in
        --date-time)
            date +'📅  %a, %e %b ⌚ %H : %M'
            ;;
        --noti-stat)
            [ -s "$DONT_DISTURB_MODE" ] && echo 🔕 || echo 🔔
            ;;
        --wifi)
            if connected; then
                printf "🌏 %s" \
                    "$(awk 'FNR == 3 { printf "%03d", $3*100/70 }' /proc/net/wireless)"
            else
                echo ❗ 000%
            fi
            ;;
        --sys-stat)
            cpu="$(top -b -n 1 | awk '(NR==3){
    if( $8 == "id," )
        print "00"
    else
        printf "%02d", 100 - $8
    }')"
            mem="$(free -m | awk '(NR==2){ printf "%04d", $3 }')"
            temp="$(sensors | awk '(/Core 0/){printf $3}' | sed 's/\.0//; s/+//')"
            echo "🌡 $temp   🐎 $cpu%   🧠 $mem"
            ;;
        --vol-stat)
            volstat="$(amixer get Master)"
            echo "$volstat" | grep -o -m 1 "off" > /dev/null && echo 🔇 000% ||
                printf "🔊 %03d%%" "$(echo "$volstat" | grep -o -m 1 "[0-9]\+%")"
            ;;
        --mailbox)
            printf "📫 %s" \
                find ~/.local/share/mail/gmail/INBOX/new/* -type f | wc -l
            ;;
        *) break ;;
    esac
    shift
done
