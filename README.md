# Alfred: My daily driver shell scripts

## Installation

```sh
git clone https://github.com/salman-abedin/alfred.git && cd alfred && sudo make install
```

## Usage

| Command                                 | Effects                                                                  |
| --------------------------------------- | ------------------------------------------------------------------------ |
| `backlight --[up,down]`                 | Modulates backlight levels                                               |
| `battery --block-charge`                | Blocks charging at high capacity for battery longevity                   |
| `battery --monitor`                     | **Cron** script to monitor battery levels & act accordingly              |
| `battery --plugged`                     | **Udev** script to notify on plugging/unplugging                         |
| `checkstorage <PATH1> <THRESHOLD1> ...` | Notifies on low storage level                                            |
| `compile [--clean]`                     | Compiles & Cleans development leftovers of a file based on its extension |
| `connected`                             | Checks if wifi & internet is up or not                                   |
| `extract [--clean]`                     | Extract & Cleans an archive based on its extension                       |
| `launch --choose`                       | Shows a dmenu prompt to pick launch programs                             |
| `launch --devour`                       | xdg-open alternative combined with terminal swallowing                   |
| `launch --link`                         | Launches programs based on url                                           |
| `mirror --arch`                         | Syncs all my packages                                                    |
| `mirror --git`                          | Syncs my personal repositories                                           |
| `mirror --mail`                         | Syncs my mails                                                           |
| `mirror --phone`                        | Syncs my phone & local files via wifi                                    |
| `mirror --repos`                        | Syncs my followed git repositories                                       |
| `panel --bspwm`                         | Generates bspwm workspace module                                         |
| `panel --date-time`                     | Generates date & time panel module                                       |
| `panel --mailbox`                       | Generates unread mail count panel module                                 |
| `panel --noti-stat`                     | Generates notification on/off status panel module                        |
| `panel --sys-stat`                      | Generates system temperature, cpu load & memory status panel module      |
| `panel --vol-stat`                      | Generates volume level panel module                                      |
| `panel --wifi`                          | Generates wifi link strength panel module                                |
| `preview`                               | Previewer script for **lf**                                              |
| `qmedia [FILE]`                         | Queues up a file on **mpv**                                              |
| `setdisplay --bg shuffle`               | Shuffles my background                                                   |
| `setdisplay --dpi`                      | Sets the correct DPI for my display resolution                           |
| `setplayer --play [next,prev,toggle]`   | Controls **spotify** & **mpd** music                                     |
| `setplayer --vol [up,down,toggle]`      | Controls volume using pulseaudio                                         |
| `toggle --noti`                         | Toggles do not disturb mode using **dunst**                              |
| `toggle --wall-reel`                    | Toggles periodic background changing                                     |
| `toggle --wifi`                         | Toggles wifi using **iwd** daemon                                        |
| `torrent --add`                         | Adds torrent to **transmission** and notifies                            |
| `torrent --downloaded`                  | Notifies when a torrent gets downloaded                                  |
| `watchmen`                              | Monitors specific directories for particular changes and runs commands   |

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
-  Bluetooth headset connect
-  Make bootable USB (linux & windows (for normies!))
-  TTF to Groff font converter
-  And much more

## Uninstallation

```sh
sudo make uninstall
```
