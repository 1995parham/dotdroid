#!/usr/bin/env bash

usage() {
	echo "Schedule periodic git-sync jobs with Android's JobScheduler"
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
	# org notes are small and worth syncing often, on any network, and the job
	# should survive reboots. Android caps the minimum period at 15 minutes.
	termux-job-scheduler \
		--script "$HOME/.shortcuts/org-sync.sh" \
		--job-id 101 \
		--period-ms 1800000 \
		--network any \
		--persisted true

	# the documents mirror is larger, so restrict it to unmetered (Wi-Fi) and
	# charging to spare mobile data and battery.
	termux-job-scheduler \
		--script "$HOME/.shortcuts/documents-sync.sh" \
		--job-id 102 \
		--period-ms 3600000 \
		--network unmetered \
		--charging true \
		--persisted true

	msg "scheduled; run 'termux-job-scheduler --pending' to review" "success"
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
