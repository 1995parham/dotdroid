#!/usr/bin/env bash

usage() {
	echo "Clone the data repositories synced by the widget shortcuts"
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
	local documents="/sdcard/Documents"
	local notes="/sdcard/Notes"

	# git refuses to operate on /sdcard repos (owned by Android's media provider,
	# not the Termux uid) unless they are marked safe. Register the resolved
	# paths (/sdcard is a symlink to /storage/emulated/0) before cloning.
	local dir
	for dir in \
		"/storage/emulated/0/Documents/documents" \
		"/storage/emulated/0/Documents/profile-pics" \
		"/storage/emulated/0/Documents/travels" \
		"/storage/emulated/0/Notes/org"; do
		git config --global --get-all safe.directory | grep -qxF "$dir" ||
			git config --global --add safe.directory "$dir"
	done

	# clone is idempotent: it clones when missing and fast-forwards when the repo
	# already exists with the expected origin. A pre-existing non-git folder is
	# reported and left untouched rather than overwritten.
	clone "git@github.com:parham-alvani/documents" "$documents"
	clone "git@github.com:parham-alvani/profile-pics" "$documents"
	clone "git@github.com:parham-alvani/travels" "$documents"
	clone "git@github.com:parham-alvani/notes" "$notes" "org"
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
