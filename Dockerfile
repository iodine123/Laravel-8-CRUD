FROM composer:latest as build
WORKDIR /app
COPY application /app
RUN composer install

FROM php:7.1.8-apache
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