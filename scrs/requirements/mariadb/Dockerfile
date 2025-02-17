# Use Alpine as the base
FROM alpine:3.21

# Install MariaDB
RUN apk update && \
	apk upgrade && \
	apk add --no-cache mariadb mariadb-client

# Copy configuration and init script
COPY conf/init.sql /docker-entrypoint-initdb.d/init.sql

# Prepare MariaDB runtime directory
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Initialize MariaDB system tables
RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql

# Expose MariaDB port
EXPOSE 3306

# On container startup, check if the "mysql" schema is empty.
# If it is, run the initialization (install system tables and bootstrap the init.sql).
CMD ["/bin/sh", "-c", "\
    if [ -z \"$(ls -A /var/lib/mysql/mysql 2>/dev/null)\" ]; then \
        echo 'Initializing database...'; \
        mariadb-install-db --user=mysql --datadir=/var/lib/mysql && \
        mysqld --user=mysql --bootstrap < /docker-entrypoint-initdb.d/init.sql; \
    fi; \
    exec mysqld --user=mysql --console \
"]

# Run MariaDB server
# CMD ["mysqld", "--user=mysql", "--console"]

# Use the custom entrypoint
#ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
