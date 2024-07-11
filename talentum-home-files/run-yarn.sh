#!/bin/bash
# This script starts and stops hadoop yarn service
# Prerequisit is that hdfs daemons are running
# Post running activity is to create a user home on hdfs using 'hdfs dfs -mkdir -p /user/talentum'

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
			/home/talentum/hadoop/sbin/start-yarn.sh
		else
			/home/talentum/hadoop/sbin/stop-yarn.sh
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

