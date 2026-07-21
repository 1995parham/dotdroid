#!/usr/bin/env bash

usage() {
	echo "Start sshd automatically at device boot (Termux:Boot)"
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
	mkdir -p "$HOME/.termux/boot"
	copycat "boot" "termux-boot/start-sshd.sh" "$HOME/.termux/boot/start-sshd.sh" 0
	chmod +x "$HOME/.termux/boot/start-sshd.sh"
	msg "install the Termux:Boot app and launch it once to enable boot scripts" "notice"
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
