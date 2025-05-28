FROM richarvey/nginx-php-fpm:latest

# Install Node.js and npm for Vite or other frontend assets (optional)
USER root
RUN apk update && apk add --no-cache curl nodejs npm && npm install -g npm@latest

# Copy application files
COPY . .

# Image configuration
ENV SKIP_COMPOSER 1
ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1

# Laravel configuration
ENV APP_ENV production
ENV APP_DEBUG false
ENV LOG_CHANNEL stderr
ENV COMPOSER_ALLOW_SUPERUSER 1

CMD ["/start.sh"]
