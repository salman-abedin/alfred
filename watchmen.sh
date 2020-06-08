#!/usr/bin/env sh

# Monitors a directory and runs scripts on particular changes

while :; do
    case $1 in
        --dots)
            dirs="\
            $GIT/own/magpie \
            $GIT/own/private \
            "
            inotifywait -m -r -e create,moved_to $dirs |
                while read -r event; do
                    cp -frs -t ~ \
                        "$GIT"/own/magpie/. \
                        "$GIT"/own/private/.
                done &
            ;;
        --mails)
            path=~/.local/share/mail/gmail/INBOX/new
            inotifywait -m -e move $path |
                while read -r event; do
                    refresh-block 2
                done &
            ;;
        *) break ;;
    esac
    shift
done
