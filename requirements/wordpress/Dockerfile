# Use Alpine as the base
FROM alpine:3.21

FROM php:8.1-fpm-alpine

RUN apk add --no-cache \
      wget \
      unzip \
      libpng-dev \
      libjpeg-turbo-dev \
      libxml2-dev \
      libzip-dev \
      oniguruma-dev \
    && docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql zip

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.tar.gz -O wordpress.tar.gz \
    && tar -xzf wordpress.tar.gz --strip-components=1 \
    && rm wordpress.tar.gz

RUN chown -R www-data:www-data /var/www/html

# PHP-FPM default port
EXPOSE 9000

CMD ["php-fpm"]
