#!/bin/sh

cname="postgres";
volnm="-v /home/leegs/Docker/PostgreSQL/data/pgdata:/var/lib/postgresql/data postgres";
env="-e TZ=Asia/Seoul -e POSTGRES_HOST_AUTH_METHOD=trust -e POSTGRESQL_PASSWORD=pwd -e PGDATA=/var/lib/postgresql/data/pgdata";

case "$1" in
	'start')
		echo "*** Start $cname !"
		podman run -d -p 127.0.0.1:5432:5432 --name $cname $env --hostname $cname $volnm $cname
		podman ps -f name=$cname
		;;

	'stop')
		podman stop $cname > /dev/null  && podman rm $cname > /dev/null
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
