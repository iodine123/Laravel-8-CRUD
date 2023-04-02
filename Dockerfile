FROM php:8.1-fpm-alpine

# Install required packages
RUN apk add --no-cache nginx supervisor \
    && docker-php-ext-install pdo_mysql \
    && apk add --no-cache zip unzip libzip-dev \
    && docker-php-ext-install zip \
    && apk add --no-cache oniguruma-dev \
    && docker-php-ext-install mbstring \
    && apk add --no-cache libpng-dev \
    && docker-php-ext-install gd

# Copy Nginx configuration file
COPY docker/nginx.conf /etc/nginx/nginx.conf

# Copy PHP-FPM configuration file
COPY docker/fpm-pool.conf /usr/local/etc/php-fpm.d/www.conf

# Set working directory
WORKDIR /var/www/html

# Copy the Laravel project files
COPY . .

# Install composer dependencies
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-interaction --no-dev --prefer-dist --optimize-autoloader --no-progress

# Generate the Laravel application key
RUN php artisan key:generate

# Expose port 80
EXPOSE 80

# Start Supervisor to run Nginx and PHP-FPM
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]