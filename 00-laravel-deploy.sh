#!/usr/bin/env bash
echo "Running composer"
composer global require hirak/prestissimo
composer install --no-dev --working-dir=/var/www/html
echo "Caching config..."
php artisan config:cache
echo "Caching routes..."
php artisan route:cache
echo "Setting SQLite permissions..."
chmod 775 /var/www/html/database/database.sqlite
chown www-data:www-data /var/www/html/database/database.sqlite
echo "Running migrations..."
php artisan migrate --force
