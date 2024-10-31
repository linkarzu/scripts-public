#!/usr/bin/env bash

# Filename: ~/github/scripts-public/macos/mac/305-bannerOn.sh
# ~/github/scripts-public/macos/mac/305-bannerOn.sh

# This script is executed from karabiner, but in karabiner docs:
# https://karabiner-elements.pqrs.org/docs/json/complex-modifications-manipulator-definition/to/shell-command/
# The very limited environment variables are passed to the command, $HOME, $UID, $USER, etc.
# Export environment variables in shell_command if your commands depend them.
#
# If you don't do this, the script won't find yabai or jq or any other apps in
# the /opt/homebrew/bin dir
export PATH="/opt/homebrew/bin:$PATH"

# Function to show the banner
show_banner() {
  touch ~/github/dotfiles-latest/youtube-banner.txt
  # tmux source-file ~/.tmux.conf
  # BTT does not recognize my path variable, so I specify the full path
  tmux source-file ~/.tmux.conf
  # sleep 0.10
}

# Function to hide the banner
hide_banner() {
  rm ~/github/dotfiles-latest/youtube-banner.txt
  # tmux source-file ~/.tmux.conf
  # BTT does not recognize my path variable, so I specify the full path
  tmux source-file ~/.tmux.conf
  # sleep 0.10
}

# Call the functions one after the other
show_banner
hide_banner
show_banner
hide_banner
show_banner
hide_banner
show_banner
hide_banner
show_banner

# sketchybar --reload
# BTT does not recognize my path variable, so I specify the full path
# /opt/homebrew/bin/sketchybar --reload
