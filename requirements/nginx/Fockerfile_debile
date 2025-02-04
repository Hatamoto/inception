FROM debian:bookworm-slim

# install required packages
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y nginx openssl

# create necessary directories
RUN mkdir -p /var/log/nginx

# generate a self-signed certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=localhost"

# copy the nginx configuration file
COPY conf/nginx.conf /etc/nginx/nginx.conf

# set the permissions
RUN chmod 755 /var/www/html && chown -R www-data:www-data /var/log/nginx /var/www/html	

# start the nginx service
CMD ["nginx", "-g", "daemon off;"]
