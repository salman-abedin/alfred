#!/bin/sh
#
# General purpose launching script

run() { setsid "$@" > /dev/null 2>&1 & }

launch_dwm() {
   while :; do
      dwm 2> ~/.dwm.log
   done
}

bookmark() {
   # xdotool key Control+l && sleep 1 && exit
   # xdotool keyup j key --clearmodifiers Control+l && sleep 1 && exit
   # xte 'keydown Control_L' 'keydown l' 'keyup Control_L' 'keyup l' && exit
   # xte 'keydown Super_L' 'keydown t' 'keyup Super_L' 'keyup t' && exit
   # xte 'keydown Super_L' 'keydown t' && sleep 0.2 && xte 'keyup Super_L' 'keyup t' && exit
   # xte 'keydown Ctrl_L' 'keydown l' && sleep 0.2 && xte 'keyup Ctrl_L' 'keyup l' && exit
   BOOKMARKS=/mnt/horcrux/git/own/private/.local/share/bookmarks
   LOCATION=$(find $BOOKMARKS -type d |
      awk -F / '{print $NF}' |
      $DMENU -p 'Bookamark location') &&
      TITLE=$($DMENU -p 'Bookamrk title') &&
      LINK=$($DMENU -p 'Bookamrk link') &&
      echo "$LINK" > "$(find $BOOKMARKS -type d -name "$LOCATION")"/"$TITLE".link
}

choose() {
   choice=$(printf "📕 Zathura\n📘 Evince\n📖 Foxit Reader\n📙 Master PDF Editor\n💻 Code\n🎥 MPV\n🌏 Browser" |
      $DMENU -p "Open with" | sed "s/\W//g") &&
      case "$choice" in
         Zathura) run zathura "$1" ;;
         Evince) run evince "$1" ;;
         Browser) run $BROWSER --new-window "$1" ;;
         FoxitReader) run foxitreader "$1" ;;
         MasterPDFEditor) run masterpdfeditor4 "$1" ;;
         Code) run code "$1" ;;
         MPV) run mpv "$1" ;;
            # MPV) run mpv --shuffle "$1" ;;
      esac
}

link() {
   case "$1" in
      *mkv | *webm | *mp4 | *mp3 | *youtube.com/watch* | *youtube.com/playlist* | *youtu.be*)
         qmedia "$1"
         ;;
      *)
         run firefox "$1"
         ;;
   esac
}

explorer() {
   launch --tmux 2> /dev/null # Personal Script
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
   fi
   tmux send "explore ${1:-~}" "Enter"
}

launch_file() {
   case $1 in
      *.ar.*)
         alacritty \
            --config-file ~/.config/alacritty/alacritty_ar.yml \
            -e "$EDITOR" "$@" &
         exit
         ;;
      *.link)
         $BROWSER "$(cat "$@")"
         exit
         ;;
      *.sent)
         devour sent "$@" &
         sleep 1
         # bspc node -t fullscreen
         xdotool key Super+f
         exit
         ;;
   esac

   case $(file --mime-type "$1" -bL) in
      text* | *x-empty | *json | *octet-stream)
         $EDITOR "$1"
         # exit
         ;;
      *directory)
         explore "$1"
         ;;
      video* | audio* | *gif)
         qmedia "$1"
         # testt mpv "$@"
         ;;
      *pdf | *postscript | *epub+zip | *vnd.djvu)
         devour zathura "$@"
         # devour zathura -- "$@"
         ;;
      image*)
         devour feh -F -A "setdisplay --bg %f" -B 'black' \
            -d --edit --keep-zoom-vp --start-at \
            "$@"
         ;;
      *x-bittorrent)
         torrent --add "$1"
         ;;
      *.document)
         pandoc "$1" -o "${1%.*}.pdf"
         devour zathura "${1%.*}.pdf"
         ;;
      application*)
         extract --clean "$1"
         ;;
      *)
         return
         ;;
   esac

}

terminal() {
   if pidof tmux > /dev/null 2>&1; then
      tmux new-window
   else
      tmux new-session -d \; switch-client
   fi
   pidof "$TERMINAL" || "$TERMINAL" -e tmux attach &
   # if pidof "$TERMINAL"; then
   # [ "$(pidof "$TERMINAL")" != "$(xdo pid)" ] &&
   # xdo activate -N st-256color
   # xdo activate -N Alacritty
   # else
   # "$TERMINAL" -e tmux attach &
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
   # fi
}

launch_tmux() {
   pidof tmux > /dev/null 2>&1 || {
      tmux new-session -d -n 'news&mail' 'calcurse' \; \
         split-window -h 'neomutt' \; \
         split-window 'newsboat' \; \
         split-window 'weechat' \; \
         select-pane -t :.1
   }
}

while :; do
   case $1 in
      --tmux | -t) launch_tmux ;;
      --terminal | -T) terminal ;;
      --file | -f) shift && launch_file "$1" ;;
      --choose | -c) shift && choose "$1" ;;
      --link | -l) shift && link "$1" ;;
      --explorer | -e) shift && explorer "$1" ;;
      --bookmark | -b) bookmark ;;
      --dwm | -d) launch_dwm ;;
      *) break ;;
   esac
   shift
done
