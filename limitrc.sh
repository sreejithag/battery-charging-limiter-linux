#!/usr/bin/env bash

max="$1"

create_init() {
    if [ "$max" -ge  1 ]; then
	    if echo "$max" | grep -E -q '^[0-9]+$'; then
		    if [ "$max" -gt 100 ] || [ "$max" -le 0 ]; then
			    echo "Please enter a valid max limit between [1-100]"
		    else
		        echo "$max" > /sys/class/power_supply/BAT?/charge_control_end_threshold || (echo "Could not create init script    :(" && exit)
			    echo "Max battery capacity is set to be limiting to $max%    $(tput setaf 2)✓ $(tput sgr0)"

                cp batlimit /etc/init.d/
                rc-update add batlimit default || (echo "Could not add service to runlevel default    :(" && exit)
                echo "Openrc init script \"batlimit\" added to runlevel default     $(tput setaf 2)✓ $(tput sgr0)"
		    fi
	    else
		    echo "Please enter a numeric max value"
	    fi
    else
	    echo "Please enter the max limit and try again"
    fi
}

check_root() {
    echo "checking permissions..."

    if [ "$EUID" -ne 0 ]
        then return 1
    fi

    return 0
}

if ! check_root; then
    echo "You must run this script as root"
    exit
else
    echo "root    $(tput setaf 2)✓ $(tput sgr0)"
    create_init
fi
