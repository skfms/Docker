#!/bin/sh

cname="ora12";
volnm="-v ./data/oradata:/app/oracle/oradata";

case "$1" in
	'start')
		podman run -itd -p 1512:1521 --name $cname --hostname $cname $volnm $cname
		echo "*** Start $cname !"
		;;

	'stop')
		podman rm -f $cname
		echo "*** Stop $cname !"
		;;

	'status')
		podman ps -f name=$cname
		;;

	*)
		echo "Usaage: $0 {start | stop | status}";
		exit 1;
		;;

esac

exit 0;
