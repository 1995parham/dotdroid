#!/usr/bin/env bash

usage() {
	echo "Make ssh server safe and secure"

	# shellcheck disable=1004,2016
	echo '
         _
 ___ ___| |__
/ __/ __| |_ \
\__ \__ \ | | |
|___/___/_| |_|
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
	echo "
PasswordAuthentication no
" | tee "$PREFIX/etc/ssh/sshd_config.d/20-pam.conf"
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
