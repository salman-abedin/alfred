#!/bin/sh
#
# Misc video editing scripts

case $1 in
   --add-audio | -aa)
      ffmpeg \
         -i "$2" \
         -stream_loop -1 -i "$3" \
         -filter_complex "[0:a][1:a]amerge=inputs=2[a]" \
         -map 0:v -map "[a]" \
         -c:v copy -c:a mp3 \
         -shortest -y \
         "${2%.*}"-"$(date +'%Y%b%d-%H%M%S')"."${2##*.}"
      # -c:a aac -strict experimental -b:a 192k -ac 2 \
      ;;
   --change-volume | -cv)
      echo "Volume level? ( 00 to 99)"
      read -r level
      ffmpeg \
         -i "$2" \
         -af "volume=0.$level" \
         -y \
         "${2%.*}"-"$(date +'%Y%b%d-%H%M%S')"."${2##*.}"
      ;;
   --make-gif | -mg)
      PALETTE="/tmp/palette.png"
      FILTERS="fps=5,scale=720:-1:flags=lanczos"
      ffmpeg -i "$2" -vf "$FILTERS,palettegen" -y $PALETTE
      ffmpeg \
         -i "$2" -i $PALETTE -y \
         -lavfi "$FILTERS [x]; [x][1:v] paletteuse" \
         "${2%.*}"-"$(date +'%Y%b%d-%H%M%S')".gif
      rm -f $PALETTE
      ;;
   --cut | -c)
      echo "Starting Point? (ex. 00:00)"
      read -r start
      echo "Endin Point? (ex. 00:05)"
      read -r end
      ffmpeg -y -i "$2" -ss "00:$start" -to "00:$end" \
         "${2%.*}"-"$(date +'%Y%b%d-%H%M%S')"."${1##*.}"
      ;;
   --join | -j)
      for vid in "$PWD"/*.mkv; do
         echo "file '$vid'" >> list
         ffmpeg -f concat -i list -c copy -y all.mkv
         rm list
      done
      ;;
esac
