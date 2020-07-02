# Alfred

My daily driver shell scripts

## Installation

```sh
git clone https://github.com/salman-abedin/alfred.git && cd alfred && sudo make install
```

## Usage

| Command                                 | Effects                                                                  |
| --------------------------------------- | ------------------------------------------------------------------------ |
| `compile [--clean]`                     | Compiles & Cleans development leftovers of a file based on its extension |
| `extract [--clean]`                     | Extract & Cleans an archive based on its extension                       |
| `connected`                             | Checks if wifi & internet is up or not                                   |
| `setplayer [next,prev,toggle]`          | Controls Spotify & mpd music                                             |
| `preview`                               | Previewer script for lf                                                  |
| `launch --devour`                       | xdg-open alternative combined with terminal swallowing                   |
| `launch --link`                         | Launches programs based on url                                           |
| `launch --choose`                       | Shows a dmenu prompt to pick launch programs                             |
| `toggle --wifi`                         | Toggles wifi using **iwd** daemon                                        |
| `toggle --wall-reel`                    | Toggles periodic background changing                                     |
| `toggle --noti`                         | Toggles do not disturb mode using **dunst**                              |
| `watchmen`                              | Monitors specific directories for particular changes and runs commands   |
| `battery --block-charge`                | Blocks charging at high capacity for battery longevity                   |
| `battery --monitor`                     | Cron script to monitor battery level & act accordingly                   |
| `battery --plugged`                     | Udev script to notify on plugging/unplugging                             |
| `setdisplay --dpi`                      | Sets the correct DPI for my display resolution                           |
| `setdisplay --bg shuffle`               | Shuffles my background                                                   |
| `setdisplay --bg toggle-reel`           | Toggles periodic background changing                                     |
| `mirror --phone`                        | Syncs my phone & local files via wifi                                    |
| `mirror --arch`                         | Syncs all my packages                                                    |
| `mirror --git`                          | Syncs all my repositories                                                |
| `mirror --mail`                         | Syncs my mails                                                           |
| `panel --date-time`                     | Generates date & time panel module                                       |
| `panel --wifi`                          | Generates wifi link strength panel module                                |
| `panel --mailbox`                       | Generates unread mail count panel module                                 |
| `panel --noti-stat`                     | Generates notification on/off status panel module                        |
| `panel --vol-stat`                      | Generates volume level panel module                                      |
| `panel --sys-stat`                      | Generates system temperature, cpu load & memory status panel module      |
| `torrent --add`                         | Adds torrent to transmission and notifies                                |
| `torrent --downloaded`                  | Notifies when a torrent gets downloaded                                  |
| `checkstorage <PATH1> <THRESHOLD1> ...` | Notifies on low storage level                                            |

## More highlights

-  **FFmpeg scripts**

   -  Videos joiner & trimmer
   -  Volume reducer
   -  Music adder
   -  GIF maker
   -  Screenshotter

-  **Recording**

   -  Screenshot
   -  Screencast
   -  Audio
   -  Webcam

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
