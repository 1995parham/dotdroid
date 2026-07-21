#!/data/data/com.termux/files/usr/bin/env bash

# https://stackoverflow.com/questions/3822621/how-to-exit-if-a-command-failed
set -eu
set -o pipefail

port=8022

pkill sshd || true
sshd

# Android blocks ip/ifconfig for unprivileged apps, so read the Wi-Fi address
# from termux-api instead of parsing the network interfaces directly.
ip_addr=""
if type termux-wifi-connectioninfo >/dev/null 2>&1; then
	ip_addr=$(termux-wifi-connectioninfo 2>/dev/null | sed -n 's/.*"ip": *"\([^"]*\)".*/\1/p' || true)
fi
ip_addr=${ip_addr:-unknown}

msg="ssh -p $port $ip_addr"
echo "$msg"

if type termux-notification >/dev/null 2>&1; then
	termux-notification -t "sshd running" -c "$msg" --alert-once --id 1375
fi
