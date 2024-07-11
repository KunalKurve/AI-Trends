#!/bin/bash
# This script starts and stops kafka zookeeper service

function usage() {
  echo "Usage: ${0} -s OPTION" >&2
  echo ' -s OPTION Specify the service start or stop mode'
  echo ' OPTION will be either start or stop'
  exit 1
}

if [[ "${#}" -eq 0 ]]
then
	usage
fi

while getopts s: OPTION
do
  case ${OPTION} in
    s)
	ARGSTRING="${OPTARG}"
	if [ "${ARGSTRING}" != "start"  ] && [ "${ARGSTRING}" != "stop"  ]
	then
		usage
	else
		if [[ "${ARGSTRING}" = "start" ]]
		then
			 /home/talentum/kafka/bin/zookeeper-server-start.sh /home/talentum/kafka/config/zookeeper.properties
		else
			 /home/talentum/kafka/bin/zookeeper-server-stop.sh
		fi
	fi
	;;
    ?)
	usage
	;;
  esac
done

# Remove the options while leaving the remaining arguments
shift "$(( OPTIND - 1 ))"
if [[ "${#}" -gt 0 ]]
then
	usage
fi

