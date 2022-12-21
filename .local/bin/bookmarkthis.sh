#!/bin/bash

bookmark="$(xclip -o)"
file="$HOME/.local/share/bookmarks"

if grep -q "^$bookmark$" "$file"; then
    notify-send -t 3000 "NOPE!" "$bookmark already exists in $file"
else
    echo "$bookmark" >> "$file" && \
    notify-send -t 3000 "ADDED!" "$bookmark added to $file"
fi
