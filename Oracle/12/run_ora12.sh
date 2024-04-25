#!/bin/sh

cname="ora12";
volnm="-v ./data:/app/oracle/oradata";

case "$1" in
	'start')
		podman run -itd -p 1521:1521 --name $cname --hostname $cname $volnm $cname
		;;

	'stop')
		podman stop $cname && podman rm $cname
		pnum=`netstat -nltp 2> /dev/null | grep 1521 | awk {'print $7;}' | awk -F'/' '{print $1;}'`
		kill $pnum
		;;

	'status')
		;;

	*)
		echo "Usaage: $0 {start | stop | status}";
		exit 1;
		;;

esac

echo ''
podman ps

exit 0;
