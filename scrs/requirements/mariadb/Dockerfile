# Use Alpine as the base
FROM alpine:3.20

# Install MariaDB
RUN apk update && \
	apk upgrade && \
	apk add --no-cache mariadb mariadb-client

# Copy configuration file
COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

# Copy db init script
COPY conf/init.sql /docker-entrypoint-initdb.d/init.sql
RUN chown mysql:mysql /docker-entrypoint-initdb.d/init.sql


# Prepare MariaDB runtime directory
RUN mkdir -p /run/mysqld /var/lib/mysql && chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Initialize MariaDB system tables
RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql

# Expose MariaDB port
EXPOSE 3306

# Use the custom entrypoint
COPY ./tools/entrypoint.sh .
RUN chmod +x ./entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
