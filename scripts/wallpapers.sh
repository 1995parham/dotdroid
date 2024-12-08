#!/usr/bin/env bash
usage() {
  echo "Provide wallpapers into pictures folder to use them"

  # shellcheck disable=1004,2016
  echo '
               _ _
__      ____ _| | |_ __   __ _ _ __   ___ _ __ ___
\ \ /\ / / _` | | | |_ \ / _` | |_ \ / _ \ |__/ __|
 \ V  V / (_| | | | |_) | (_| | |_) |  __/ |  \__ \
  \_/\_/ \__,_|_|_| .__/ \__,_| .__/ \___|_|  |___/
                  |_|         |_|
  '
}

root=${root:?"root must be set"}

pre_main() {
  return 0
}

main_pacman() {
  return 1
}

main_xbps() {
  return 1
}

main_apt() {
  return 1
}

main_pkg() {
  rsync -av "$root/wallpapers/" "/sdcard/Pictures/wallpapers"

  termux-wallpaper -l -f "$root/wallpapers/lockscreen.jpg"
  termux-wallpaper  -f "$root/wallpapers/mainscreen.jpg"
}

main_brew() {
  return 1
}

main() {
  return 0
}

main_parham() {
  return 0
}
