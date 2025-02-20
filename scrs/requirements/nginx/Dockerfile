# Use Alpine as the base
FROM alpine:3.20

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
RUN mkdir -p /var/log/nginx /var/www/html /etc/nginx/certs/

# Copy your custom nginx.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN chmod 644 /etc/nginx/nginx.conf

# Copy entrypoint script
COPY tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set ownership and permissions
RUN chown -R nginx:nginx /var/www/html && chmod 755 /var/www/html

# Expose port 443 for HTTPS only
EXPOSE 443

# Run nginx in the foreground
#CMD ["nginx", "-g", "daemon off;"]
ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]