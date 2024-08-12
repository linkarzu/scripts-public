#!/usr/bin/env bash

# Filename: ~/github/scripts/macos/mac/310-bannerOff.sh
# ~/github/scripts/macos/mac/310-bannerOff.sh

rm ~/github/dotfiles-latest/youtube-banner.txt

# tmux source-file ~/.tmux.conf
# BTT does not recognize my path variable, so I specify the full path
/opt/homebrew/bin/tmux source-file ~/.tmux.conf

# sketchybar --reload
# BTT does not recognize my path variable, so I specify the full path
# /opt/homebrew/bin/sketchybar --reload
