#!/usr/bin/env bash

usage() {
	echo "Bootstrap dotdroid for Termux"

	# shellcheck disable=1004,2016
	echo '
 ____              _           _
| __ )  ___   ___ | |_ ___  __| |
|  _ \ / _ \ / _ \| __/ _ \/ _` |
| |_) | (_) | (_) | ||  __/ (_| |
|____/ \___/ \___/ \__\___|\__,_|
  '
}

# Optional extras to run after the base setup.
export additionals=(
	"motd"
	"termux-widget"
	"wallpapers"
	"ssh"
	"boot"
	"schedule"
)

pre_main() {
	if yes_or_no "bootstrap" "run pkg update and pkg upgrade?"; then
		pkg update
		pkg upgrade -y
	fi

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
	require_pkg git openssh rsync fd ripgrep termux-api

	if [[ ! -d "${HOME}/storage" ]]; then
		msg "requesting storage permission (needed for /sdcard)"
		if command -v termux-setup-storage >/dev/null 2>&1; then
			termux-setup-storage
		else
			msg "termux-setup-storage not found; install termux-tools" "warn"
		fi
	fi
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
