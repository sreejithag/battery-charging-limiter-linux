#!/bin/bash

max="$1"

if [ "$#" -ge  1 ]; then
	if echo $max | grep -E -q '^[0-9]+$'; then 
		if [ "$max" -gt 100 ] || [ "$max" -le 0 ]; then
			echo "Please enter a valid max limit between [1-100]"
		else
			echo "Max battery capacity is limiting to $max % `tput setaf 2`✓ `tput sgr0`"
			echo $max | sudo tee /sys/class/power_supply/BAT?/charge_control_end_threshold > /dev/null
            cd /tmp
            echo "[Unit]
Description=To set battery charge threshold
After=multi-user.target suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target

[Service]
Type=oneshot
ExecStart=/bin/bash -c 'echo $max > /sys/class/power_supply/BAT?/charge_control_end_threshold'

[Install]
WantedBy=multi-user.target suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target
" > battery-manager.service

            echo "created battery-manager.service `tput setaf 2`✓ `tput sgr0`"

            sudo cp battery-manager.service /etc/systemd/system/

            sudo systemctl enable battery-manager.service

            echo "Battery manager service enabled `tput setaf 2`✓ `tput sgr0`"

		fi
	else
		echo "Please enter a numeric max value"
	fi
else
	echo "Please enter the max limit and try again"
fi
