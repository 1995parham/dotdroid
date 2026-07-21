#!/data/data/com.termux/files/usr/bin/env bash

# https://stackoverflow.com/questions/3822621/how-to-exit-if-a-command-failed
set -eu
set -o pipefail

function message() {
	if type termux-notification >/dev/null 2>&1; then
		termux-notification -c "$1" -t git-sync-documents --alert-once --id 1374
	fi
	echo "$1"
}

function repository_force_sync() {
	local local_folder=$1

	# Navigate to the local folder. Explicit checks are used throughout because
	# set -e is ignored inside a function invoked in a `||` context, so we must
	# stop on failure ourselves (e.g. never reset --hard onto a stale FETCH_HEAD).
	cd "$local_folder" || {
		message "Error: cannot enter $local_folder."
		return 1
	}

	# Check if it's a Git repository (a worktree/submodule uses a .git file)
	if [ ! -e ".git" ]; then
		message "Error: $local_folder is not a Git repository."
		return 1
	fi

	# Fetch the remote repository
	message "Fetching remote repository..."
	git fetch origin main || {
		message "Error: fetch failed for $local_folder (network?)."
		return 1
	}

	# Reset the local branch to the remote branch (force)
	message "Resetting local branch to remote..."
	git reset --hard "FETCH_HEAD" || {
		message "Error: reset failed for $local_folder."
		return 1
	}

	# Clean up untracked files and directories (note: -x also removes ignored files)
	message "Cleaning up untracked files..."
	git clean -fdx || {
		message "Error: clean failed for $local_folder."
		return 1
	}

	message "Synchronization complete for $local_folder."
}

repos="documents profile-pics travels"

# mark each repo as a safe directory (idempotent: git config --add would
# otherwise append a duplicate line to ~/.gitconfig on every run)
for repo in $repos; do
	dir="/storage/emulated/0/Documents/$repo"
	git config --global --get-all safe.directory | grep -qxF "$dir" ||
		git config --global --add safe.directory "$dir"
done

# sync each repo independently so a single network failure does not abort
# the others (set -e would otherwise stop the whole script on first error)
failed=""
for repo in $repos; do
	repository_force_sync "/sdcard/Documents/$repo" || failed="$failed $repo"
done

if [ -n "$failed" ]; then
	message "Sync failed for:$failed"
	exit 1
fi
