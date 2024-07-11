#!/bin/bash
# This script starts and stops hbase
# Prerequisit is that hadoop hdfs and yarn services are running

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
			/home/talentum/hbase/bin/start-hbase.sh
			/home/talentum/hbase/bin/local-master-backup.sh start 2
			/home/talentum/hbase/bin/local-regionservers.sh start 3
		else
			/home/talentum/hbase/bin/local-regionservers.sh stop 3
			cat /tmp/hbase-talentum-2-master.pid|xargs kill -9
			/home/talentum/hbase/bin/stop-hbase.sh
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

