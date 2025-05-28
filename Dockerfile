FROM richarvey/nginx-php-fpm:latest

# Install Node.js and npm with a specific version compatible with the image
USER root
RUN apk update \
    && apk add --no-cache curl nodejs=18.20.1-r0 npm \
    && npm install -g npm@latest \
    && npm cache clean --force

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
