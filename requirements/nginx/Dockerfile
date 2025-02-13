# Use Alpine as the base
FROM alpine:3.21

# Ensure necessary system files exist
RUN touch /etc/passwd /etc/group /etc/shadow

# Install openssl first
RUN apk update && \
    apk upgrade && \
    apk add --no-cache openssl

# Create nginx user and group AFTER ensuring system files exist
RUN addgroup -S nginx && adduser -S -h /var/www nginx -G nginx

# Install nginx AFTER user/group are confirmed
RUN apk add --no-cache nginx

# Create necessary directories (same as before)
RUN mkdir -p /var/log/nginx /var/www/html

# Generate a self-signed certificate (same OpenSSL commands)
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=localhost"

# Copy your custom nginx.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Set ownership and permissions
RUN chown -R nginx:nginx /var/www/html && chmod 755 /var/www/html

# Expose port 80 (and 443 if you plan to serve HTTPS)
# EXPOSE 80 
EXPOSE 443

# Run nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
