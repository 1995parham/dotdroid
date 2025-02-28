#!/bin/bash

# https://stackoverflow.com/questions/3822621/how-to-exit-if-a-command-failed
set -eu
set -o pipefail

function message() {
  if type termux-notification >/dev/null; then
    termux-notification -c "$1" -t git-sync-org --alert-once --id 1373
  fi
  echo "$1"
}

function repository_force_sync() {
  local local_folder=$1

  # Navigate to the local folder
  cd "$local_folder"

  # Check if it's a Git repository
  if [ ! -d ".git" ]; then
    message "Error: $local_folder is not a Git repository."
    return 1
  fi

  # Fetch the remote repository
  message "Fetching remote repository..."
  git fetch origin main

  # Reset the local branch to the remote branch (force)
  message "Resetting local branch to remote..."
  git reset --hard "FETCH_HEAD"

  # Clean up untracked files and directories (optional, but recommended for a truly clean sync)
  message "Cleaning up untracked files..."
  git clean -fdx

  message "Synchronization complete."
}

git config --global --add safe.directory /storage/emulated/0/Documents/documents
git config --global --add safe.directory /storage/emulated/0/Documents/profile-pics
git config --global --add safe.directory /storage/emulated/0/Documents/travels

repository_force_sync /sdcard/Documents/documents
repository_force_sync /sdcard/Documents/profile-pics
repository_force_sync /sdcard/Documents/travels
