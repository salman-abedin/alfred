#!/bin/sh
#
# Monitors specific directores for particular changes and runs commands

MAIL_DIR=~/.local/share/mail/INBOX/new

inotifywait -m -e delete move $MAIL_DIR |
   while read -r line; do
      uniblocks -u mail
   done

#===============================================================================
#                             Exp
#===============================================================================

# echo "
# $GIT/own/magpie
# $GIT/own/private
# " |
#    xargs inotifywait -m -r -e create,moved_to |
#    while read -r line; do
#       cp -frsu -t ~ \
#          "$GIT"/own/magpie/. \
#          "$GIT"/own/private/.
#    done &
