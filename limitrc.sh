#!/usr/bin/env bash

limit="$1"

throw_err() {
    if [ $# -eq 0 ]; then
        msg="Unknown error occurred"
    else
        msg="$1"
    fi

    echo "$msg    :("
    exit 1
}

set_limit() {
    echo "$limit" > /sys/class/power_supply/BAT?/charge_control_end_threshold || throw_err "Could not create init script"
	echo "Max battery capacity is set to be limiting to $limit%    $(tput setaf 2)✓ $(tput sgr0)"
}

create_init() {
    cd /tmp || throw_err "Could not cd into /tmp"

    echo "#!/sbin/openrc-run" > batlimit || throw_err "Could not create init script"
    {
    echo ""
    echo "name=\$RC_SVCNAME"
    echo "description=\"limit battery charging\""
    echo "command=\"echo $limit > /sys/class/power_supply/BAT?/charge_control_end_threshold\""
    echo "pidfile=\"/run/\${RC_SVCNAME}.pid\""
    } >> batlimit

    echo "init script creation complete    $(tput setaf 2)✓ $(tput sgr0)"

    cp batlimit /etc/init.d/
    rc-update add batlimit default || throw_err "Could not add service to runlevel default"
    echo "Openrc init script \"batlimit\" added to runlevel default     $(tput setaf 2)✓ $(tput sgr0)"
}

check_val() {
    if ! echo "$limit" | grep -E -q '^[0-9]+$'; then
        echo "Enter a numeric max limit"
    elif [ "$limit" -gt 100 ] || [ "$limit" -le 0 ]; then
		echo "Please enter a valid max limit between [1-100]"
    else
        return 0
    fi

    return 1
}

check_root() {
    echo "checking permissions..."

    if [ "$EUID" -ne 0 ]; then
        echo "You must run this script as root"
        return 1
    fi

    echo "root    $(tput setaf 2)✓ $(tput sgr0)"
    return 0
}


if check_val && check_root; then
    if set_limit
    then create_init
    fi
else
    exit 1
fi
