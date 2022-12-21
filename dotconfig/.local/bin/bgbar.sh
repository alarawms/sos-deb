#!/bin/bash
interval=0
#############################
#       FONT COLORS
#############################
fgwhite="+@fg=0;"
fgwhite2="+@fg=1;"
fgred="+@fg=2;"
fggreen="+@fg=3;"
fgyellow="+@fg=4;"
fgblue="+@fg=5;"
fgpurple="+@fg=6;"
fgdarkgray="+@fg=7;"
fgmidgray="+@fg=8;"

#############################
#   BACKGROUND COLORS
#############################
bgdarkgray="+@bg=0;"
bgmidgray="+@bg=1;"
bgred="+@bg=2;"
bgbrightred="+@bg=3;"
bggreen="+@bg=4;"
bglightgreen="+@bg=5;"
bgblue="+@bg=6;"
bglightblue="+@bg=7;"
bgyellow="+@bg=8;"
bgbrightyellow="+@bg=9;"

##############################
#	    DISK
##############################
hdd() {
	  free="$(df -h /home | awk '/dev/ {print $3}' | sed 's/G/Gb/')"
      perc="$(df -h /home | awk '/dev/ {print $5}')"
      number="$(df -h /home | awk '/dev/ {print $5}' | sed 's/%//')"
      if [[ $number -le 50 ]]; then
        printf "$bggreen $fgdarkgray   $bglightgreen $perc($free) $bgdarkgray "
      elif [[ $number -ge 51 ]] && [[ $number -le 89 ]]; then
        printf "$bgyellow $fgdarkgray  $bgbrightyellow $perc($free) $bgdarkgray "
      elif [[ $number -ge 90 ]]; then
        printf "$bgred $bgdarkgray   $bgbrightred $perc($free) $bgdarkgray "
      fi
}
##############################
#	    RAM
##############################
mem() {
    used="$(free | awk '/Mem:/ {print $3}')"
    total="$(free | awk '/Mem:/ {print $2}')"
    human="$(free -h | awk '/Mem:/ {print $3}' | sed s/i//g)"
    percent="$(( 200 * $used/$total - 100 * $used/$total ))"
    ram="$(( 200 * $used/$total - 100 * $used/$total ))%($human) "

    if [[ $percent -le 25 ]]; then
        printf "$bggreen $fgdarkgray   $bglightgreen $ram $bgdarkgray "
    elif [[ $percent -ge 26 ]] && [[ $percent -le 75 ]];  then
        printf "$bgyellow $fgdarkgray   $bgbrightyellow $ram $bgdarkgray "
    elif [[ $percent -ge 76 ]] && [[ $percent -le 100 ]]; then
        printf "$bgred $fgdarkgray   $bgbrightred $ram $bgdarkgray "
    fi
}
##############################
#	    CPU
##############################
cpu() {
    read cpu a b c previdle rest < /proc/stat
	prevtotal=$((a+b+c+previdle))
	sleep 0.5
	read cpu a b c idle rest < /proc/stat
	total=$((a+b+c+idle))
	cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))

    cpu_value=$(grep -o "^[^ ]*" /proc/loadavg)

    if [[ $cpu -le 80 ]]; then
        echo "$bgblue $fgdarkgray   $bglightblue $cpu_value% $bgdarkgray "
    elif [[ $cpu -ge 81 ]]; then
        echo "$bgred $fgdarkgray   $bgbrightred $cpu_value% $bgdarkgray "
    fi
}

##############################
#	    VOLUME ICON
##############################
volicon() {
    VOLONOFF="$(amixer -D pulse get Master | awk '/Left:/ {print $6}' | sed 's/[][]//g')"
    VOL="$(amixer -D pulse get Master | awk '/Left:/ {print $5}' | sed 's/[][]//g; s/%//')"
    LOWVOL=" "
    MIDVOL="墳"
    HIVOL=" "
    VOLOFF="婢"

    if [[ "$VOLONOFF" = "off" ]] || [[ "$VOL" = 0 ]]; then
        echo "$bgred $fgdarkgray $VOLOFF $bgbrightred $VOL $bgdarkgray "
    elif [[ "$VOL" -ge 1 ]] && [[ "$VOL" -le 25 ]]; then
        echo "$bgblue $fgdarkgray $LOWVOL $bglightblue $VOL% $bgdarkgray "
    elif [[ "$VOL" -ge 26 ]] && [[ "$VOL" -le 74 ]]; then
        echo "$bgyellow $fgdarkgray $MIDVOL $bgbrightyellow $VOL% $bgdarkgray "
    elif [[ "$VOL" -ge 75 ]] ; then
        echo "$bggreen $fgdarkgray $HIVOL $bglightgreen $VOL% $bgdarkgray"
    fi
}

##############################
#	    UPGRADES
##############################
upgrades(){
	updates="$(aptitude search '~U' | wc -l)"
    if [ "$updates" = 0 ]; then
        printf "$bgyellow $fgdarkgray   $bgbrightyellow fully updated $bgdarkgray "
    else
    	printf "$bgred $fgdarkgray   $bgbrightred $updates updates $bgdarkgray "
    fi
}
##############################
#	    NETWORK ICON
##############################
networkicon() {
wire="$(ip a | awk '/enp/ && /inet/ || /eth/ && /inet/ {print $NF}' | wc -l)"
wifi="$(ip a | awk '/wlan/ && /inet/ {print $NF}' | wc -l)"
if [ $wire = 1 ]; then
    printf "$fgwhite  "
elif [ $wifi = 1 ]; then
    printf "$fgyellow $fgwhite"
else
    printf "$fgred睊$fgwhite"
fi
}
#############################
#       IP ADDRESS
#############################
ipaddress() {
    address="$(ip a | awk '/.255/ {print $2}' | sed -e 's|/24||' -e 1q)"
    printf "$bgmidgray $fgwhite $address"
}
############################
#       VPN CONNECTION
############################
vpnconnection() {
    state="$(ip a | awk '/tun0/ && /inet/ {print $NF}' | wc -l)"
if [ $state = 1 ]; then
    printf "$bglightgreen $fgdarkgray ﳣ  $bgdarkgray"
else
    printf "$bgbrightred $fgdarkgray ﳤ  $bgdarkgray "
fi
}
###########################
#    WEATHER VARIABLES
###########################
weather=$(awk '/value/ {print $2 $3}' ~/.config/weather.txt | sed -e 's/\"//g' -e 1q)
temp=$(awk '/temp_F/ {print $2}' ~/.config/weather.txt | sed -e 's/\"//g' -e 's/,//')
nocloud="盛"
cloud=""
lotempicon=""
midtempicon=""
hitempicon=""

###########################
#       TEMP ICON
###########################
tempicon() {
if [ "$temp" -gt 80 ]; then
	printf  "$bgred $fgdarkgray $hitempicon $bgbrightred $temp $bgdarkgray"
elif [ "$temp" -ge 50 ] && [ "$temp" -le 79 ]; then
	printf "$bgyellow $fgdarkgray $midtempicon $bgbrightyellow $temp $bgdarkgray"
elif [ "$temp" -le 49 ]; then
	printf "$bgblue $fgdarkgray $lotempicon $bglightblue $temp $bgdarkgray"
fi
}
###########################
#       WEATHER ICON
###########################
weathericon() {
    weather=$(awk '/value/ {print $2" "$3}' ~/.config/weather.txt | sed -e 's/\"//g' -e 1q)
    case "$weather" in
        "Clear ") icon="盛" ;;
        "Sunny ") icon="盛" ;;
        "Partly cloudy") icon="" ;;
        "Cloudy") icon=" " ;;
        "Overcast") icon=" " ;;
        "Fog") icon=" " ;;
        "Mist") icon=" " ;;
        "Light rain") icon=" " ;;
        "Light drizzle") icon=" " ;;
        "Rain") icon=" " ;;
        "Patchy rain") icon=" " ;;
        "Moderate rain") icon=" " ;;
        "Thunderstorm in") icon=" " ;;
        *) icon="" ;;
    esac

   if [ $icon = 盛 ]; then
       echo "$bgyellow $fgdarkgray $icon $bgbrightyellow $weather"
   else
       printf "$bgblue $fgdarkgray $icon $bglightblue $weather"
   fi
}

###########################
#       BATTERY
###########################
#bat() {
#batstat="$(cat /sys/class/power_supply/BAT0/status)"
#battery="$(cat /sys/class/power_supply/BAT0/capacity)"
#    if [ $batstat = 'Unknown' ]; then
#    batstat="$fggreen "
#    elif [[ $battery -ge 5 ]] && [[ $battery -le 19 ]]; then
#    batstat="$fgred "
#    elif [[ $battery -ge 20 ]] && [[ $battery -le 39 ]]; then
#    batstat="$fgyellow "
#    elif [[ $battery -ge 40 ]] && [[ $battery -le 59 ]]; then
#    batstat="$fgyellow "
#    elif [[ $battery -ge 60 ]] && [[ $battery -le 79 ]]; then
#    batstat="$fgyellow "
#    elif [[ $battery -ge 80 ]] && [[ $battery -le 95 ]]; then
#    batstat="$fggreen "
#    elif [[ $battery -ge 96 ]] && [[ $battery -le 100 ]]; then
#    batstat="$fggreen "
#fi
#printf "$batstat  $battery %"
#}
#############################
#   CLOCK ICON
#############################
clockicon() {
    CLOCK=$(date '+%I')
    case "$CLOCK" in
    "00") icon="" ;;
    "01") icon="" ;;
    "02") icon="" ;;
    "03") icon="" ;;
    "04") icon="" ;;
    "05") icon="" ;;
    "06") icon="" ;;
    "07") icon="" ;;
    "08") icon="" ;;
    "09") icon="" ;;
    "10") icon="" ;;
    "11") icon="" ;;
    "12") icon="" ;;
    esac
    echo "$bggreen $fgdarkgray $(date "+$icon")"
}
#############################
#       DATE FORMATTED
#############################
dateinfo() {
    echo "$bggreen $fgdarkgray $(date "+%b %d %Y (%a)")"
}
#############################
#       TIME FORMATTED
#############################
clockinfo() {
    echo "$bgdarkgray $fgyellow $(date "+%R") "
}

#subs() {
#    subscribers="$(cat $HOME/.config/subs.txt)"
#    echo "$bgred $fgwhite   $bgbrightred $fgdarkgray $subscribers $bgdarkgray "
#}


#sleeptime=2
#loops forever outputting a line every SLEEP_SEC secs
while true; do
    [ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(upgrades)
    interval=$((interval + 1))

sleep 1 && echo "$(cpu) $(mem) $(upgrades) $(hdd) $(networkicon) $(ipaddress) $(vpnconnection) $(volicon) $(weathericon) $(tempicon) $(dateinfo) $(clockicon) $(clockinfo) "
    #sleep $sleeptime
	done
