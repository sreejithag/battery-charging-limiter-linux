#!/bin/bash

max="$1"

if [ "$#" -ge  1 ]; then
	if echo $max | grep -E -q '^[0-9]+$'; then 
		if [ "$max" -gt 100 ] || [ "$max" -le 0 ]; then
			echo "Please eneter a valid max limit between [1-100]"
		else
			echo "Max battery capacity is limiting to $1%"
			echo $max | sudo tee /sys/class/power_supply/BAT?/charge_control_end_threshold			
		fi
	else
		echo "Please enter a numeric max value"
	fi
else
	echo "Please enter the max limit and try again"
fi
