# Use the official PHP image as the base image
FROM php:8.1-fpm

# Install required PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/html

# Copy the Laravel application files to the container
COPY application .

# Install dependencies
RUN composer install --no-interaction --no-scripts --prefer-dist --optimize-autoloader

# Copy the Nginx configuration file
COPY /application/nginx.conf /etc/nginx/conf.d/default.conf

# Expose the port used by Nginx
EXPOSE 80

# Start PHP-FPM and Nginx
CMD ["sh", "-c", "service php8.1-fpm start && nginx -g 'daemon off;'"]