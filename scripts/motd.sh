#!/usr/bin/env bash
usage() {
  echo "Message of the day"

  # shellcheck disable=1004,2016
  echo '
                 _      _
 _ __ ___   ___ | |_ __| |
| |_ ` _ \ / _ \| __/ _` |
| | | | | | (_) | || (_| |
|_| |_| |_|\___/ \__\__,_|
  '
}



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
  copycat "motd" motd/motd "$PREFIX/etc/motd" "0"
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
