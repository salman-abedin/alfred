#!/usr/bin/env sh

# All purpose syncing script
# mirror --[git,mail,calcurse,phone,arch,firefox]

FIREFOXPROFILE=zmzk0pef

if ! connected; then
    notify-send -t 3000 -i "$ICONS"/disconnected.png "Disconnected"
    exit 1
fi

notify-send -i "$ICONS/mirror.png" "Mirroring now"

while :; do
    case $1 in
        --firefox | -f)
            rsync -a --delete ~/.mozilla/firefox/"$FIREFOXPROFILE".default-release \
                "$GIT"/own/firefox/.mozilla/firefox
            ;;
        --git | -g)
            for dir in "$GIT"/own/*/; do
                if [ -d "$dir" ]; then
                    cd "$dir" || exit 1
                    # git pull
                    git add .
                    [ -z "$(git status --porcelain)" ] && continue
                    [ "$PWD" = /mnt/horcrux/git/own/firefox ] ||
                        [ "$PWD" = /mnt/horcrux/git/own/private ] ||
                        message=$(timeout 15 rofi -dmenu -i -p "$(echo "$PWD" | awk -F / '{print $NF}')")
                    [ "$message" ] || message=$(git log -1 | tail -1 | awk '{$1=$1};1')
                    git commit -m "$message" && git push
                fi
            done
            # wait &
            # notify-send -t 3000 -i "$ICONS"/gitlab.png "Done syncing git repos"
            ;;
        --mail | -m)
            mbsync -c ~/.config/isync/mbsyncrc -a
            unread=$(find ~/.local/share/mail/gmail/INBOX/new/* -type f 2> /dev/null | wc -l)
            [ "$unread" -gt 0 ] && notify-send -t 0 -i "$ICONS/mail.png" \
                "You've got $unread new mail!"
            ;;
        --calcurse | -c)
            CALCURSE_CALDAV_PASSWORD=$(gpg -d --batch --passphrase asdlkj ~/.local/share/passwords/salmanabedin@disroot.org.gpg) calcurse-caldav
            # --init=keep-remote
            # notify-send -i "$ICONS"/calendar.png "Done syncing calcurse"
            ;;
        --arch | -a)
            doas -- pacman -Syyu --noconfirm
            yay -Syyu --noconfirm
            npm update -g
            ;;
        --phone | -p)
            ANDROIDMOUNT=/mnt/android
            ANDROIDDISK=/mnt/horcrux/phone
            # notify-send -t 3000 -i "$ICONS"/phone.png "Phone Sync" "Time to sync"
            if ! timeout 3 sshfs -p "$PORT" "$CARD" "$ANDROIDMOUNT"; then
                notify-send -t 3000 -i "$ICONS"/critical.png "Couldn't sync phone!" && exit 1
            fi
            unison -batch -fat "$ANDROIDMOUNT" "$ANDROIDDISK"
            fusermount -u "$ANDROIDMOUNT"
            # notify-send -t 3000 -i "$ICONS"/phone.png "Done Syncing"
            ;;
        --newsboat | -n)
            newsboat -x reload
            ;;
        *) break ;;
    esac
    shift
done
# wait
notify-send -i "$ICONS/mirror.png" "Done mirroring"
