#!/bin/sh
#
# Monitors specific directores for particular changes and runs commands

echo "
$GIT/own/magpie
$GIT/own/private
" |
   xargs inotifywait -m -r -e create,moved_to |
   while read -r line; do
      cp -frsu -t ~ \
         "$GIT"/own/magpie/. \
         "$GIT"/own/private/.
   done &

# path=~/.local/share/mail/gmail/INBOX/new
# inotifywait -m -e move $path |
#     while read -r line; do
#         refresh-block 2
#     done &
