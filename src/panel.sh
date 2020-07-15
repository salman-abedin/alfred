#!/bin/sh
#
# Panel Module Generator
# Dependencies: date, awk, sed, grep, top, free, sensors, alsa-utils
# Usage: panel -(b|d|s|v|w)

case $1 in
   --date-time | -d)
      date +'🗓  %a, %d %b   🕰 %H : %M'
      ;;
   --wifi | -w)
      if connected; then
         printf "🌏 %s" \
            "$(awk 'FNR == 3 { printf "%03d", $3*100/70 }' /proc/net/wireless)"
      else
         echo "❗ 000"
         iwctl station "$(ip link | grep -o 'w.*:' | tr -d ':')" scan
         # wifi -c
      fi
      ;;
   --sys-stat | -s)
      cpu="$(top -b -n 1 | awk '(NR==3){
    if( $8 == "id," )
        print "000"
    else
        printf "%03d", 100 - $8
    }')"
      mem="$(free -m | awk '(NR==2){ printf "%04d", $3 }')"
      temp="$(sensors | awk '(/Core 0/){printf $3}' | sed 's/\.0//; s/+//')"
      printf "🧠 %s  🐎 %s 🌡 %s" "$mem" "$cpu" "$temp"
      ;;
   --vol-stat | -v)
      # DUMMY_FIFO=/tmp/dff
      showstat() {
         if amixer get Master | grep -o -m 1 "off" > /dev/null; then
            printf "🔇 000"
         else
            printf "🔊 %03d" \
               "$(amixer get Master | grep -o -m 1 "[0-9]\+%" | sed 's/%//')"
         fi
      }
      # trap 'showstat' RTMIN+1
      # trap 'rm -f "$DUMMY_FIFO"; exit' INT TERM QUIT EXIT
      showstat
      # mkfifo "$DUMMY_FIFO"
      # while :; do
      #    : < "$DUMMY_FIFO" &
      #    wait
      # done
      ;;
   # --bspwm | -b)
   #    bspc subscribe report |
   #       while read -r line; do
   #          line=${line#*:}
   #          line=${line%:L*}
   #          IFS=:
   #          set -- $line
   #          wm=
   #          while :; do
   #             case $1 in
   #                [FOU]*) name=🏚 ;;
   #                f*) name=🕳 ;;
   #                o*) name=🌴 ;;
   #                *) break ;;
   #             esac
   #             if [ -z "$wm" ]; then
   #                wm="$name" && shift && continue
   #             else
   #                wm="$wm  $name"
   #             fi
   #             shift
   #          done
   #          # echo "W$wm"
   #          echo "$wm"
   #       done
   #    ;;
   # --mailbox | -m)
   #    printf "📫 %s" \
   #       find ~/.local/share/mail/gmail/INBOX/new/* -type f | wc -l
   #    ;;
   # --noti-stat | -n)
   #    if [ -s "$DDM" ]; then echo 🔕; else echo 🔔; fi
   #    ;;
   *) exit 1 ;;
esac
