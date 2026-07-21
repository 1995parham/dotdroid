#!/data/data/com.termux/files/usr/bin/env bash

# https://stackoverflow.com/questions/3822621/how-to-exit-if-a-command-failed
set -eu
set -o pipefail

if ! type termux-sms-send >/dev/null 2>&1; then
	echo "termux-sms-send not found; install Termux:API and the termux-api package." >&2
	exit 1
fi

# Widgets in ~/.shortcuts open a terminal, so we can prompt interactively.
# Multiple recipients may be given comma-separated (see termux-sms-send -n).
printf 'Recipient number(s): '
read -r number
if [ -z "$number" ]; then
	echo "no number given; aborting." >&2
	exit 1
fi

printf 'Message: '
read -r message
if [ -z "$message" ]; then
	echo "empty message; aborting." >&2
	exit 1
fi

# Sending an SMS is outward-facing (and may cost money), so confirm first.
printf 'Send to %s: "%s" ? [y/N] ' "$number" "$message"
read -r reply
case "$reply" in
[yY] | [yY][eE][sS]) ;;
*)
	echo "cancelled."
	exit 0
	;;
esac

# termux-sms-send exits 0 even on failure (e.g. a missing permission), printing
# a JSON error instead, so inspect its output rather than the exit status.
output=$(termux-sms-send -n "$number" "$message" 2>&1)
if [ -n "$output" ]; then
	echo "failed to send: $output" >&2
	echo "(is the SMS permission granted to Termux:API?)" >&2
	exit 1
fi

echo "sent."
if type termux-notification >/dev/null 2>&1; then
	termux-notification -t "SMS sent" -c "to $number" --alert-once --id 1376
fi
