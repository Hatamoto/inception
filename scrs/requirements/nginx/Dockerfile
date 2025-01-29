FROM debian:bookworm-slim

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y nginx OpenSSL

RUN mkdir -p /var/run/nginx

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=localhost"

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 var/www/html && chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]
