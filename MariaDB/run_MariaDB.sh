#!/bin/sh

cname="mariadb";
volnm="-v /home/leegs//Docker/MariaDB/data:/var/lib/mysql -v /home/leegs/Docker/MariaDB/log:/var/log/mysql";
env="-e TZ=Asia/Seoul -e MARIADB_ROOT_PASSWORD=pwd -e MARIADB_DATABASE=test";

case "$1" in
        'start')
                podman run -d -p 127.0.0.1:3306:3306 --name $cname $env --hostname $cname $volnm $cname
                ;;

        'stop')
                podman stop $cname && podman rm $cname
				pnum=`netstat -nltp 2> /dev/null | grep 3306 | awk {'print $7;}' | awk -F'/' '{print $1;}'`
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
