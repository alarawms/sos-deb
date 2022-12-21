#!/bin/bash
spectrconf="$HOME/.config/spectrwm/spectrwm.conf"
spectrpid="$(ps -aux | awk '/spectrwm$/ {print $2}')"
bgbar="$(grep /bgbar.sh $spectrconf | wc -l)"
if [ $bgbar = 1 ]; then
    sed -i 's/\/bgbar.sh/\/bar.sh/' $spectrconf && kill -HUP $spectrpid
else
    sed -i 's/\/bar.sh/\/bgbar.sh/'  $spectrconf && kill -HUP $spectrpid
fi

