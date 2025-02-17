# Use Alpine as the base
FROM alpine:3.21

# Install PHP-FPM
FROM php:8.1-fpm-alpine

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
    && docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql zip

# Define the build argument
ARG WORDPRESS_VERSION=6.7.2

WORKDIR /var/www/html

RUN wget https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz -O wordpress.tar.gz \
    && tar -xzf wordpress.tar.gz --strip-components=1 \
    && rm wordpress.tar.gz

RUN chown -R www-data:www-data /var/www/html

# PHP-FPM default port
EXPOSE 9000

COPY ./conf/create-wp-config.sh .
#RUN sh create-wp-config.sh && rm create-wp-config.sh && \
#    chmod -R 0777 wp-content/
RUN chmod +x ./create-wp-config.sh && chmod -R 0777 wp-content/
ENTRYPOINT ["./create-wp-config.sh"]
CMD ["php-fpm"]