FROM composer:latest as build
WORKDIR /app
COPY application /app
RUN composer require fideloper/proxy
RUN composer install

FROM php:8.2.2-apache
EXPOSE 8000
COPY --from=build /app /app
COPY application/vhost.conf /etc/apache2/sites-available/000-default.conf
RUN chgrp -R www-data /app
RUN chmod -R 775 /app/storage
RUN a2enmod rewrite
RUN php artisan migrate
RUN php artisan cache:clear
RUN php artisan config:clear
RUN php artisan view:clear
RUN php artisan key:generate
RUN php artisan route:clear
RUN php artisan serve 