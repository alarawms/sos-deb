#!/bin/bash

brand="$(cat /sys/devices/virtual/dmi/id/sys_vendor | awk '{print $1}')"

model="$(cat /sys/devices/virtual/dmi/id/product_name)"

printf "$brand $model\n"
