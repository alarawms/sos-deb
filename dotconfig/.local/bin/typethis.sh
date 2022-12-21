#!/bin/bash

type="$(grep -v '^#' $HOME/.local/share/bookmarks | cut -d' ' -f1 | dmenu -i -l 20)"

xdotool type $type
