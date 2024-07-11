#!/bin/bash
# This script starts hiveserver2 service
# Prerequisit is that 1) hadoop cluster is running
# 2) A /user/hive/warehouse folder is there in HDFS
# 3) A HiveMetastore service is running

function usage() {
  echo "Usage: ${0} -s OPTION" >&2
  echo ' -s OPTION Specify the service start or stop mode'
  echo ' start OPTION will be start'
  echo ' stop OPTION will be stop'
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
			# nohup hive --service hiveserver2 &
			hive --service hiveserver2
			
		else
			meta_pid=`pgrep -f org.apache.hive.service.server.HiveServer2`

    			if [[ -n "$meta_pid" ]]
    			then
        			echo "Found hivesevrer2 PID-- "$meta_pid
        			kill $meta_pid
        			# if process is still around, use kill -9
        			if ps -p $meta_pid > /dev/null ; then
            				echo "Initial kill failed, killing with -9 "
            				kill -9 $meta_pid
        			fi
    				echo "Hive server2 stopped successfully"
    			else
        			echo "Hive server2 process not found , Hive server2 is not running !!!"
    			fi
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

