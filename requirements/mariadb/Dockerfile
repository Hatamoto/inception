# Use Alpine as the base
FROM alpine:3.21

# Install MariaDB
RUN apk update && \
	apk upgrade && \
	apk add --no-cache mariadb mariadb-client

# Copy configuration and init script
COPY init.sql /docker-entrypoint-initdb.d/init.sql

# Prepare MariaDB runtime directory
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Initialize MariaDB system tables
RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql

# Expose MariaDB port
EXPOSE 3306

# Entry script to ensure init.sql runs only on first startup
CMD ["/bin/sh", "-c", "\
    if [ ! -d /var/lib/mysql/mysql ]; then \
        mariadb-install-db --user=mysql --datadir=/var/lib/mysql; \
        mysqld --user=mysql --bootstrap < /docker-entrypoint-initdb.d/init.sql; \
    fi; \
    exec mysqld --user=mysql --console \
"]

# Run MariaDB server
CMD ["mysqld", "--user=mysql", "--console"]
