# Use Alpine as the base
FROM alpine:3.21.2

# Set the maintainer
USER nginx

# Install packages via apk
RUN apk update && \
    apk upgrade && \
	addgroup -S nginx && adduser -S nginx -G nginx && \
    apk add --no-cache nginx openssl

# Create necessary directories (same as before)
RUN mkdir -p /var/log/nginx /var/www/html

# Generate a self-signed certificate (same OpenSSL commands)
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=localhost"

# Copy your custom nginx.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Set permissions (adjust the user/group to match whichever you're actually using)
RUN chown -R nginx:nginx /var/www/html /var/log/nginx

# Expose port 80 (and 443 if you plan to serve HTTPS)
EXPOSE 80

# For SSL (https), you might also EXPOSE 443
EXPOSE 443

# Run nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
