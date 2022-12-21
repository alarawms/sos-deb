#!/bin/bash
#Declare colors
red='\033[0;31m'
nc='\033[0m'
yellow='\033[1;33m'

scratch () {
    case $1 in
        pad)
            winclass="$(xdotool search --class scratchpad)"
            if [ -z "$winclass" ]; then
                kitty --class scratchpad 2> /dev/null
            else
                if [ ! -f /tmp/scratchpad ]; then
                    touch /tmp/scratchpad && xdo hide "$winclass"
                elif [ -f /tmp/scratchpad ]; then
                    rm /tmp/scratchpad && xdo show "$winclass"
                fi
            fi
            ;;
        pulse)
            winclass="$(xdotool search --class scratchpulse)"
            if [ -z "$winclass" ]; then
                kitty --class scratchpulse -e pulsemixer 2> /dev/null
            else
                if [ ! -f /tmp/scratchpulse ]; then
                    touch /tmp/scratchpulse && xdo hide "$winclass"
                elif [ -f /tmp/scratchpulse ]; then
                    rm /tmp/scratchpulse && xdo show "$winclass"
                fi
            fi
            ;;
        vifm)
            winclass="$(xdotool search --class scratchvifm)"
            if [ -z "$winclass" ]; then
                kitty --class scratchvifm -e vifmrun 2> /dev/null
            else
                if [ ! -f /tmp/scratchvifm ]; then
                    touch /tmp/scratchvifm && xdo hide "$winclass"
                elif [ -f /tmp/scratchvifm ]; then
                    rm /tmp/scratchvifm && xdo show "$winclass"
                fi
            fi
            ;;
        sfm)
            winclass="$(xdotool search --class scratchsfm)"
            if [ -z "$winclass" ]; then
                kitty --class scratchsfm -e sfm 2> /dev/null
            else
                if [ ! -f /tmp/scratchsfm ]; then
                    touch /tmp/scratchsfm && xdo hide "$winclass"
                elif [ -f /tmp/scratchsfm ]; then
                    rm /tmp/scratchsfm && xdo show "$winclass"
                fi
            fi
            ;;
        fzf)
            winclass="$(xdotool search --class scratchfzf)"
            if [ -z "$winclass" ]; then
                kitty --class scratchfzf -e fzf-launcher.sh 2> /dev/null
            else
                if [ ! -f /tmp/scratchfzf ]; then
                    touch /tmp/scratchfzf && xdo hide "$winclass"
                elif [ -f /tmp/scratchfzf ]; then
                    rm /tmp/scratchfzf && xdo show "$winclass"
                fi
            fi
            ;;
        *)
            printf ${red}"invalid argument: ${nc} $1 \n"
            printf ${yellow}"valid arguments are:\n"
            printf "pad\n"
            printf "pulse\n"
            printf "vifm\n"
            printf "sfm\n"
            printf "fzf ${nc}\n" && exit 1
            ;;

    esac
}

scratch $1
