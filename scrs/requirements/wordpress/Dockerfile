# Use Alpine as the base
FROM alpine:3.20

# Install PHP-FPM
FROM php:8.1-fpm-alpine

# Define the build argument
ARG WORDPRESS_VERSION=6.7.2

# Install dependencies
RUN apk add --no-cache \
      wget \
      unzip \
      libpng-dev \
      libjpeg-turbo-dev \
      libxml2-dev \
      libzip-dev \
      oniguruma-dev \
      mariadb-client \
	  bash \
      curl \
    && docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql zip

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

RUN wget https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz -O wordpress.tar.gz \
    && tar -xzf wordpress.tar.gz --strip-components=1 \
    && rm wordpress.tar.gz

RUN chown -R www-data:www-data /var/www/html

EXPOSE 9000

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY ./conf/wp-config.php /usr/local/bin/wp-config.php
RUN chmod +x /usr/local/bin/entrypoint.sh && chmod -R 0777 wp-content/

ENTRYPOINT [ "sh", "/usr/local/bin/entrypoint.sh" ]