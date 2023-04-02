FROM php:7.4-fpm-alpine

# Install required PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install git
RUN apk add --no-cache git

# Set working directory
WORKDIR /var/www/html

# Copy Laravel application files
COPY application .

# Install dependencies
RUN composer install --no-dev --prefer-dist --optimize-autoloader --no-scripts --no-progress

# Set permissions for Laravel storage directory
RUN chown -R www-data:www-data storage

# Copy Nginx configuration file
COPY application/nginx.conf /etc/nginx/nginx.conf

# Install Nginx
RUN apk add --no-cache nginx

# Expose port 80
EXPOSE 80

# Start Nginx and PHP-FPM services
CMD service nginx start && php-fpm