# Use Alpine as the base
FROM alpine:3.21.2

RUN apt update && apt upgrade && apt install -y \ 
	mariadb-server

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/
COPY init.sql /etc/mysql/init.sql

RUN mkdir -p /run/mysqld

CMD ["mysqld", "--user=root", "--console"]
