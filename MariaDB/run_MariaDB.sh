#!/bin/sh

cname="mariadb";
volnm="-v /home/leegs/Docker/MariaDB/data:/var/lib/mysql";
env="-e TZ=Asia/Seoul -e MARIADB_ROOT_PASSWORD=pwd -e MARIADB_DATABASE=test";

case "$1" in
        'start')
				echo "***Start $cname !"
                podman run -d -p 127.0.0.1:3306:3306 --name $cname $env --hostname $cname $volnm $cname
				podman ps -f name=$cname
                ;;

        'stop')
                podman stop $cname > /dev/null && podman rm $cname > /dev/null
				echo "***Stop $cname !"
				#pnum=`netstat -nltp 2> /dev/null | grep 3306 | awk {'print $7;}' | awk -F'/' '{print $1;}'`
				#kill $pnum
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
