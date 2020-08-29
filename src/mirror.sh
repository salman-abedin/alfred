#!/bin/sh
#
# General purpose syncing script
# mirror --[git,calcurse,phone,arch,repos,upstream]

if ! connected; then
   notify-send -t 3000 -i "$ICONS"/disconnected.png "Disconnected"
   exit 1
fi

notify-send -i "$ICONS/mirror.png" "Mirroring now"

while :; do
   case $1 in
      --git | -g)
         for dir in "$GIT"/own/*/ "$GIT"/suckless/*/; do
            if [ -d "$dir" ]; then
               cd "$dir" || exit 1
               # git pull
               git add .
               [ -z "$(git status --porcelain)" ] && continue
               [ "${PWD##*/}" = private ] ||
                  message=$(timeout 15 sh -c " : | $DMENU -p $(echo $PWD | awk -F / '{print $NF}')")
               [ -z "$message" ] && message=$(git log -1 | tail -1 | awk '{$1=$1};1')
               git commit -m "$message" && git push
            fi
         done
         # wait &
         # notify-send -t 3000 -i "$ICONS"/gitlab.png "Done syncing git repos"
         ;;

      --calcurse | -c)
         CALCURSE_CALDAV_PASSWORD=$(gpg -d ~/.local/share/passwords/salmanabedin@disroot.org.gpg) calcurse-caldav
         # --init=keep-remote
         # notify-send -i "$ICONS"/calendar.png "Done syncing calcurse"
         ;;

      --arch | -a)
         doas -- pacman -Syyu --noconfirm
         yay -Syu --noconfirm
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

      --repos | -r)
         for dir in "$GIT"/others/*/; do
            [ -d "$dir" ] && git -C "$dir" pull --rebase
         done
         ;;

      --upstream | -u)
         for dir in "$GIT"/forks/*/; do
            if [ -d "$dir" ]; then
               cd "$dir" || exit
               git fetch upstream
               git rebase upstream/master
            fi
         done
         ;;

      --dots | -d)
         cp -frsu -t ~ \
            "$GIT"/own/magpie/. \
            "$GIT"/own/private/.
         doas -- find ~ -xtype l -delete
         ;;

      --drive | -D)
         LOCAL=/mnt/horcrux/drive
         CLOUD=drive:synced
         FIREFOXPROFILE=zmzk0pef

         # Firefox backup
         tar cf firefox.tar.gz ~/.mozilla/firefox/$FIREFOXPROFILE.default-release
         gpg -r salmanabedin@disroot.org -e firefox.tar.gz
         rclone copy firefox.tar.gz.gpg $CLOUD
         rm firefox.tar.gz firefox.tar.gz.gpg

         rclone sync $LOCAL $CLOUD
         rclone sync "$GIT"/others $CLOUD/git/others
         rclone sync "$GIT"/forks $CLOUD/git/forks
         ;;
      *) break ;;
   esac
   shift
done
# wait
notify-send -i "$ICONS/mirror.png" "Done mirroring"

#===============================================================================
#                             Exp
#===============================================================================

# --firefox | -f)
# rsync -a --delete ~/.mozilla/firefox/"$FIREFOXPROFILE".default-release \
#    "$GIT"/own/firefox/.mozilla/firefox
# ~/.mozilla/firefox/"$FIREFOXPROFILE".default-release
# curl -T firefox.tar.gz \
# -u "salmanabedin@disroot.org:$(gpg -d --batch --passphrase asdlkj \
# ~/.local/share/passwords/salmanabedin@disroot.org.gpg)" \
# https://cloud.disroot.org/remote.php/dav/files/salmanabedin/
# ;;
# --mail | -m)
# mbsync -c ~/.config/isync/mbsyncrc -a
# unread=$(find ~/.local/share/mail/gmail/INBOX/new/* -type f 2> /dev/null | wc -l)
# [ "$unread" -gt 0 ] && notify-send -t 0 -i "$ICONS/mail.png" \
# "You've got $unread new mail!"
# ;;

# --newsboat | -n)
# newsboat -x reload
# pgrep -f newsboat$ && /usr/bin/xdotool key --window "$(/usr/bin/xdotool search --name newsboat)" R && exit
# ;;
