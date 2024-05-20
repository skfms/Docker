#!/bin/sh

case "$1" in
        'start')
                podman-compose -f mariadb.yml up -d
                ;;

        'stop')
                podman-compose -f mariadb.yml down
                ;;

        'status')
                podman-compose -f mariadb.yml ps
                ;;

        *)
                echo "Usaage: $0 {start | stop | status}";
                exit 1;
                ;;

esac

exit 0;

