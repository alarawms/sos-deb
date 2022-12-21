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
##############################
#	    DISK
##############################
hdd() {
	  free="$(df -h /home | awk '/dev/ {print $3}' | sed 's/G/Gb/')"
      perc="$(df -h /home | awk '/dev/ {print $5}')"
      number="$(df -h /home | awk '/dev/ {print $5}' | sed 's/%//')"
      if [[ $number -le 50 ]]; then
        printf "$fggreen    $perc($free) $fgwhite"
      elif [[ $number -ge 51 ]] && [[ $number -le 89 ]]; then
        printf "$fgyellow    $perc($free) $fgwhite"
      elif [[ $number -ge 90 ]]; then
        printf "$fgred    $perc($free) $fgwhite"
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
        printf "$fggreen  $fgwhite $ram "
    elif [[ $percent -ge 26 ]] && [[ $percent -le 75 ]];  then
        printf "$fgyellow    $fgwhite $ram "
    elif [[ $percent -ge 76 ]] && [[ $percent -le 100 ]]; then
        printf "$fgred    $fgwhite $ram "
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
        echo "$fgblue  $fgwhite $bgdarkgray $cpu_value% "
    elif [[ $cpu -ge 81 ]]; then
        echo "$fgred   $fgwhite $bgdarkgray  $cpu_value% "
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
        echo "$fgred $VOLOFF $fgwhite $VOL "
    elif [[ "$VOL" -ge 1 ]] && [[ "$VOL" -le 25 ]]; then
        echo "$fggreen $LOWVOL $fgwhite $VOL% "
    elif [[ "$VOL" -ge 26 ]] && [[ "$VOL" -le 74 ]]; then
        echo "$fgyellow $MIDVOL $fgwhite $VOL% "
    elif [[ "$VOL" -ge 75 ]] ; then
        echo "$fgpurple $HIVOL $fgwhite $VOL% "
    fi
}

##############################
#	    UPGRADES
##############################
upgrades(){
	updates="$(aptitude search '~U' | wc -l)"
    if [ "$updates" = 0 ]; then
        printf "$fgyellow  fully updated $fgwhite"
    else
    	printf "$fgred  $updates updates $fgwhite"
    fi
}
##############################
#	    NETWORK ICON
##############################
networkicon() {
wire="$(ip a | awk '/enp/ && /inet/ || /eth/ && /inet/ {print $NF}' | wc -l)"
wifi="$(ip a | awk '/wlan/ && /inet/ {print $NF}' | wc -l)"
if [ $wire = 1 ]; then
    printf "$fgwhite "
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
    printf "$fgwhite $address"
}
############################
#       VPN CONNECTION
############################
vpnconnection() {
    state="$(ip a | awk '/tun0/ && /inet/ {print $NF}' | wc -l)"
if [ $state = 1 ]; then
    printf "$fggreen ﳣ $fgdarkgray "
else
    printf "$fgred ﳤ $fgdarkgray "
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
	printf  "$fgred $hitempicon $fgwhite $temp "
elif [ "$temp" -ge 50 ] && [ "$temp" -le 79 ]; then
	printf "$fgyellow $midtempicon $fgwhite $temp "
elif [ "$temp" -le 49 ]; then
	printf "$fgblue $lotempicon $fgwhite $temp "
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
       echo "$fgyellow $icon $fgwhite $weather "
   else
       printf "$fgblue $icon $fgwhite $weather"
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
    echo "$fgblue $(date "+$icon")"
}
#############################
#       DATE FORMATTED
#############################
dateinfo() {
    echo "$fgblue $(date "+%b %d %Y (%a)") $fgwhite"
}
#############################
#       TIME FORMATTED
#############################
clockinfo() {
    echo "$fgyellow $(date "+%R") "
}

#subs() {
#    subscribers="$(cat $HOME/.config/subs.txt)"
#    echo "$fgred   $fgwhite $subscribers"
#}


#sleeptime=2
#loops forever outputting a line every SLEEP_SEC secs
while true; do
    [ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(upgrades)
    interval=$((interval + 1))

sleep 1 && echo "$(cpu) $(mem) $(upgrades) $(hdd) $(networkicon) $(ipaddress) $(vpnconnection) $(volicon) $(weathericon) $(tempicon) $(dateinfo) $(clockicon) $(clockinfo) "
    #sleep $sleeptime
	done
