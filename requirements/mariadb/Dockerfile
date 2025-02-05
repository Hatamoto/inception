# Use Alpine as the base
FROM alpine:3.21.2

# Install MariaDB
RUN apk update && \
	apk upgrade && \
	apk add --no-cache mariadb mariadb-client

# Copy the custom configuration file
COPY init.sql /docker-entrypoint-initdb.d/init.sql

# Prepare MariaDB runtime directory
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Expose MariaDB port
EXPOSE 3306

# Run MariaDB server
CMD ["mysqld", "--user=mysql", "--console"]
