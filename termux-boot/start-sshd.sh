#!/data/data/com.termux/files/usr/bin/sh

# Run by the Termux:Boot addon after the device boots (install the Termux:Boot
# app and launch it once to enable this). Hold a wake lock so the CPU stays up
# for the SSH server, then reuse the widget script so starting sshd and the IP
# notification live in one place.
termux-wake-lock

if [ -x "$HOME/.shortcuts/start-sshd.sh" ]; then
	"$HOME/.shortcuts/start-sshd.sh"
else
	sshd
fi
