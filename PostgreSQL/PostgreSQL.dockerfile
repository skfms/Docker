FROM docker.io/library/postgres:16.4

#TimeZone Setting
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
RUN echo Asia/Seoul > /etc/timezone

