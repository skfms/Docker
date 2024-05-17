FROM docker.io/library/mariadb

#TimeZone Setting
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
RUN echo Asia/Seoul > /etc/timezone

# my.cnf 설정
#RUN echo "lower_case_table_names=1" >> /etc/my.cnf
#RUN echo "default-time-zone='+9:00'" >> /etc/my.cnf
#RUN echo "collation-server = utf8mb4_unicode_ci" >> /etc/my.cnf
#RUN echo "collation-server = utf8mb4_0900_ai_ci" >> /etc/my.cnf
#RUN echo "character-set-server = utf8mb4" >> /etc/my.cnf
#RUN echo "skip-character-set-client-handshake" >> /etc/my.cnf
