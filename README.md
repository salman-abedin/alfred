# Alfred

My daily driver shell scripts

## Installation

```sh
git clone https://github.com/salman-abedin/alfred.git && cd alfred && sudo make install
```

## Usage

| Command                        | Effect                                                                          |
| ------------------------------ | ------------------------------------------------------------------------------- |
| `compile`                      | Compiles a file based on its extension                                          |
| `compile --clean`              | Cleans development leftovers of a file based on its extension                   |
| `connected`                    | Checks if wifi & internet is up or not                                          |
| `setplayer [next,prev,toggle]` | Controls Spotify & mpd music                                                    |
| `preview`                      | Previewer script for lf                                                         |
| `launch --devour`              | xdg-open alternative combined with terminal swallowing                          |
| `toggle --wifi`                | Toggles wifi using **iwd** daemon                                               |
| `toggle --noti`                | Toggles do not disturb mode using **dunst**                                     |
| `watchmen --dots`              | Makes symbolic links to my home directory when there is a change in my dotfiles |
| `watchmen --mail`              | Refreshes my statusbar module on changes in inbox                               |
| `battery --block-charge`       | Blocks charging at high capacity for battery longevity                          |
| `battery --monitor`            | Cron script to monitor battery level & act accordingly                          |
| `battery --plugged`            | Udev script to notify on plugging/unplugging                                    |
| `setdisplay --dpi`             | Sets the correct dpi for my display resolution                                  |
| `setdisplay --bg shuffle`      | Shuffles my background                                                          |
| `setdisplay --bg reel`         | Changes the background every 5 minutes                                          |
| `mirror --phone`               | Syncs my phone & local files via wifi                                           |
| `mirror --arch`                | Syncs all my packages                                                           |
| `mirror --git`                 | Syncs all my repositories                                                       |
| `mirror --mail`                | Syncs my mails                                                                  |
| `panel --date-time`            | Generates date & time panel module                                              |
| `panel --wifi`                 | Generates wifi link strength panel module                                       |
| `panel --mailbox`              | Generates unread mail count panel module                                        |
| `panel --noti-stat`            | Generates notification on/off status panel module                               |
| `panel --vol-stat`             | Generates volume level panele module                                            |
| `panel --sys-stat`             | Generates system temperature, cpu load & memory status panel module             |
| `torrent --add`                | Adds torrent to transmission and notifies instantly                             |
| `torrent --downloaded`         | Notfies when a torrent gets downloaded                                          |

## More highlights

-  **FFmpeg scripts**

   -  Trim videos
   -  Join videos
   -  Reduce volume
   -  Add music to video
   -  Make GIFs

-  **Recording**

   -  Screenshot
   -  Screencast
   -  Audio
   -  Webacm

-  Google drive syncing
-  Instant googleing
-  Bluetooth headset connect
-  Update local git repos
-  Make bootable USB (linux & windows (for normies!))
-  TTF to Groff font converter
-  And much more

## Uninstallation

```sh
sudo make uninstall
```
