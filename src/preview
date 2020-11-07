#!/bin/sh
#
# Previewer script
# Dependencies: file, highlight, chafa, w3m

FILE="$1"
# HEIGHT="$2"
HIGHLIGHT_SIZE_MAX=262143 # 256KiB

case $(file --dereference --brief --mime-type "$FILE") in
   text/html)
      w3m -dump "$FILE"
      ;;
   text/* | */xml)
      [ "$(stat --printf='%s' -- "$FILE")" -gt "${HIGHLIGHT_SIZE_MAX}" ] &&
         exit 2
      highlight \
         --replace-tabs=3 \
         --out-format=xterm256 \
         --style=pablo \
         --force \
         -- "$FILE"
      # highlight --force --out-format=ansi -- "$FILE"
      ;;
   # image/*)
   #     chafa --fill=block --symbols=block --colors=256 --size="80x$HEIGHT" "$FILE" || exit 1
   #     ;;
   */pdf)
      pdftotext -l 10 -nopgbrk -q -- "$FILE" -
      ;;
   *)
      file --brief "$FILE"
      ;;
esac
