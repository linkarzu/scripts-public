#!/usr/bin/env bash

# Filename: ~/github/scripts-public/macos/mac/305-bannerOn.sh
# ~/github/scripts-public/macos/mac/305-bannerOn.sh

# Function to show the banner
show_banner() {
  touch ~/github/dotfiles-latest/youtube-banner.txt
  # tmux source-file ~/.tmux.conf
  # BTT does not recognize my path variable, so I specify the full path
  /opt/homebrew/bin/tmux source-file ~/.tmux.conf
  # sleep 0.10
}

# Function to hide the banner
hide_banner() {
  rm ~/github/dotfiles-latest/youtube-banner.txt
  # tmux source-file ~/.tmux.conf
  # BTT does not recognize my path variable, so I specify the full path
  /opt/homebrew/bin/tmux source-file ~/.tmux.conf
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
