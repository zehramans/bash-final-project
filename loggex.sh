#!/bin/bash
GREEN="\e[32m"
RESET="\e[0m"
if ! command -v figlet &> /dev/null; then
    echo "WARNING: yo download figlet for cool banners (sudo apt install figlet)."
else
    echo -e "${GREEN}"
    figlet -f big "LOGGEX"
    echo -e "${RESET}"
fi

LOG_FILE=""
LOG_FORMAT=""
while getopts "f:F:d:" opt; do
	case $opt in
		f)
		   LOG_FILE="$OPTARG"
		   ;;
		F)
		   LOG_FORMAT="$OPTARG"
		   ;;
		d)
		   DETECTION="$OPTARG"
		   ;;
		*)
		   echo "Usage $0 -f <logfile> -F <logformat> -d <detectionmode>"
		   exit 1
		   ;;
	esac
done

if [ -z "$LOG_FILE" ]; then
echo "ERROR: provide a log file "
echo "Usage '$0' -f <logfile>"
exit 1
fi

ssh_ip(){
local filename="${1:-/dev/stdin}"
grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' "$filename" | sort | uniq -c | sort -nr
}

echo "Analyzing: $LOG_FILE"

case "$LOG_FORMAT" in
	apache)
		IP_FIELD=1
		STATUS_FIELD=9
		echo "TOP IP ADRESSES"
		awk -v field="$IP_FIELD" '{print $field}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -10
		;;
	ssh)
		echo "TOP IP ADRESSES"
		ssh_ip "$LOG_FILE"
		;;
	*)
		echo "unknown file format"
		exit 1
		;;
esac

case "$DETECTION" in
	brute)
		echo "Detecting bruteforce attempts..." 
		grep -E "Failed password|Invalid user|authentication failure" "$LOG_FILE" | ssh_ip |
		awk '$1 > 3 {print $0}' 
		;;
	injection)
		echo "Detecting sql injection attempts ..."
		;;
	*)
		echo "unknown detection type"
		;;
esac
#Dec 28 10:31:00 server sshd[12346]: Failed password for invalid_user from 192.0.2.124 port 50000 ssh2
