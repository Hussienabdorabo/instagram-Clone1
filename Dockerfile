FROM richarvey/nginx-php-fpm:latest

# Install Node.js and npm with a compatible version
USER root
RUN apk update \
    && apk add --no-cache curl nodejs=18.20.1-r0 npm \
    && npm install -g npm@9.6.6 \
    && npm cache clean --force

# Copy application files
COPY . .

# Install Composer dependencies
RUN composer install --no-dev --optimize-autoloader --working-dir=/var/www/html

# Image configuration
ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1

# Laravel configuration
ENV APP_ENV production
ENV APP_DEBUG true
ENV LOG_CHANNEL stderr
ENV COMPOSER_ALLOW_SUPERUSER 1

CMD ["/start.sh"]
