#!/bin/sh
# Print the mysql user's UID and GID
echo "MySQL user details: $(id mysql)"

# Optionally, list the permissions of the current directory to debug bind mount issues:
echo "Directory permissions for /var/lib/mysql:"
ls -ld /var/lib/mysql

# Start MariaDB
exec mysqld --user=mysql --console
