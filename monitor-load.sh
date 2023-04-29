#!/bin/bash
#execute the script  every 1 min to monitor system load, and add it to file /var/log/system-load.PS: The script must be run using root.
##Exit codes:
##	0 : Normal terminated
##	1: The user is not the root

# Check if script is being run as root

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

while true
do

    # Get the system load average for the last minute
    load=$(uptime)

    # Get the current date and time
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    # Write the system load and timestamp to the log file
    echo "${timestamp} - System load: ${load}" >> /var/log/system-load.log

    # log every 60 seconds
    sleep 60
done

exit 0
