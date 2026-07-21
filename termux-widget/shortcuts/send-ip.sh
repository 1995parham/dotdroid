#!/data/data/com.termux/files/usr/bin/env bash

# https://stackoverflow.com/questions/3822621/how-to-exit-if-a-command-failed
set -eu
set -o pipefail

# One-tap SMS: send a fixed IP to a fixed recipient (no prompts).
number="90003781"
message="188.121.146.46"

if ! type termux-sms-send >/dev/null 2>&1; then
	echo "termux-sms-send not found; install Termux:API and the termux-api package." >&2
	exit 1
fi

# termux-sms-send exits 0 even when it fails (e.g. a missing permission) and
# prints a JSON error instead, so inspect its output rather than the exit status.
output=$(termux-sms-send -n "$number" "$message" 2>&1)
if [ -n "$output" ]; then
	echo "failed to send: $output" >&2
	echo "(is the SMS permission granted to Termux:API?)" >&2
	exit 1
fi

echo "sent $message to $number."
if type termux-notification >/dev/null 2>&1; then
	termux-notification -t "SMS sent" -c "$message to $number" --alert-once --id 1377
fi
