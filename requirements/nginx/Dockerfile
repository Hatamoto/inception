# Use Alpine as the base
FROM alpine:latest

# Install packages via apk
RUN apk update && \
    apk upgrade && \
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

# Optional: Alpine's nginx package typically runs as user 'nginx' by default,
# whereas your original Dockerfile uses 'www-data'. If you want to keep 
# 'www-data', you must create it manually:
RUN addgroup -g 82 -S www-data && \
    adduser -u 82 -D -S -G www-data www-data

# Set permissions (adjust the user/group to match whichever you're actually using)
RUN chown -R www-data:www-data /var/www/html /var/log/nginx && \
    chmod 755 /var/www/html

# Expose port 80 (and 443 if you plan to serve HTTPS)
EXPOSE 80

# For SSL, you might also EXPOSE 443
# EXPOSE 443

# Run nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
