#!/bin/sh

cname="gitlab";
iname="gitlab-ce:17.5.1-ce.0";
ports="-p 2022:22 -p 2080:80 -p 20443:443";
volnm="-v /home/leegs/Docker/gitlab/data/config:/etc/gitlab \
-v /home/leegs/Docker/gitlab/data/logs:/var/log/gitlab \
-v /home/leegs/Docker/gitlab/data/data:/var/opt/gitlab";
env="-e TZ=Asia/Seoul --restart always --privileged";

case "$1" in
        'start')
				echo "***Start $cname !"
                podman run -d $ports  --name $cname $env --hostname $cname $volnm $iname
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
