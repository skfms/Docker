#!/bin/sh

cname="postgres";
volnm="-v /home/leegs/Docker/PostgreSQL/data:/var/lib/postgres/data";
env="-e TZ=Asia/Seoul -e POSTGRES_HOST_AUTH_METHOD=trust -e POSTGRESQL_PASSWORD=pwd -e PGDATA=/var/lib/postgresql/data/pgdata";

case "$1" in
        'start')
                podman run -d -p 127.0.0.1:5432:5432 --name $cname $env --hostname $cname $volnm $cname
                ;;

        'stop')
                podman stop $cname && podman rm $cname
				#pnum=`netstat -nltp 2> /dev/null | grep 3306 | awk {'print $7;}' | awk -F'/' '{print $1;}'`
				#kill $pnum
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
