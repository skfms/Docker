podman run -d --name mariadb \
  -p 127.0.0.1:3306:3306 \
  -v ~/Docker/MariaDB/data:/var/lib/mysql \
  -v ~/Docker/MariaDB/log:/var/log/mysql \
  -e TZ=Asia/Seoul \
  -e MARIADB_ROOT_PASSWORD=pwd \
  -e MARIADB_DATABASE=test \
  docker.io/library/mariadb
