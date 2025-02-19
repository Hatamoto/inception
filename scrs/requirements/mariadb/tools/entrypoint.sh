#!/bin/sh

set -e  # Exit on any error

echo "Checking if MariaDB is initialized..."

# Test if the database exists by checking if the `mysql` schema is accessible
if ! mysql -u root -e 'USE mysql;' > /dev/null 2>&1; then
    echo "Initializing database..."
    
    # Initialize system tables
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    
    # Start MariaDB in the background for setup
    mysqld --user=mysql --skip-networking --socket=/var/run/mysqld/mysqld.sock &

    # Wait for the database to be ready
    until mysqladmin ping --socket=/var/run/mysqld/mysqld.sock --silent; do
        echo "Waiting for MariaDB to start..."
        sleep 2
    done

    # Run the initialization script
    echo "Running init.sql..."
    mysql --socket=/var/run/mysqld/mysqld.sock -u root < /docker-entrypoint-initdb.d/init.sql

    # Gracefully shut down MariaDB
    echo "Shutting down MariaDB after initialization..."
    mysqladmin --socket=/var/run/mysqld/mysqld.sock -u root shutdown
else
    echo "MariaDB is already set up."
fi

# Start MariaDB in the foreground
exec mysqld --user=mysql --console
