#!/bin/sh
set -ex

# Print MySQL user details to stderr
echo "MySQL user details: $(id mysql)" >&2

# Print directory permissions (for debugging)
echo "Directory permissions for /var/lib/mysql:" >&2
ls -ld /var/lib/mysql >&2

# Start MariaDB
exec mysqld --user=mysql --console