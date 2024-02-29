#!/bin/sh

cname="ora12";

case "$1" in
	'start')
		podman exec -it $cname bash -c "\$ORACLE_HOME/bin/dbstart; \$ORACLE_HOME/bin/lsnrctl start"
		;;
	'stop')
		podman exec -it $cname bash -c "\$ORACLE_HOME/bin/lsnrctl stop; \$ORACLE_HOME/bin/dbshut";
		;;
	'status')
		podman exec -it $cname bash -c "\$ORACLE_HOME/bin/lsnrctl status";
		;;
	*)
		echo "Usage: $0 {start | stop | status}";
		exit 1;
		;;
esac
exit 0;
