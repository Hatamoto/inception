#!/bin/sh

# Wait for MariaDB 
until nc -z "$WP_DB_HOST" 3306; do
    echo "Waiting for MariaDB..."
    sleep 5
done

# Check if wp-config.php exists, create if missing and populate values
if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "Creating wp-config.php from template..."
    cp /usr/local/bin/wp-config.php /var/www/html/wp-config.php

    sed -i "s/{{DB_NAME}}/${WP_DB_NAME}/g" /var/www/html/wp-config.php
    sed -i "s/{{DB_USER}}/${WP_DB_USER}/g" /var/www/html/wp-config.php
    sed -i "s/{{DB_PASSWORD}}/${WP_DB_PASSWORD}/g" /var/www/html/wp-config.php
    sed -i "s/{{DB_HOST}}/${WP_DB_HOST}/g" /var/www/html/wp-config.php
    sed -i "s/{{DOMAIN_NAME}}/${DOMAIN_NAME}/g" /var/www/html/wp-config.php
fi

# Install WP-CLI if missing
if ! command -v wp &> /dev/null; then
    echo "Installing WP-CLI..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

# Check if WordPress is already installed
if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."
    
    # Install WordPress
    wp core install --allow-root \
        --url="https://${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN}" \
        --admin_password="${WP_ADMIN_PSW}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email

	wp theme install twentytwentythree --activate --allow-root

    echo "WordPress installation completed!"
else
    echo "WordPress is already installed!"
fi

# Ensure ownership and permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Start PHP-FPM
exec php-fpm

