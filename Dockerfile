FROM composer:latest as build

WORKDIR /app
COPY application /app
RUN composer require fideloper/proxy
RUN composer install

FROM php:8.2.2-apache

RUN docker-php-ext-install pdo pdo_mysql
COPY --from=build /app /var/www/html/app
COPY application/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY application/apache2.conf /etc/apache2/apache2.conf
RUN a2enmod rewrite
EXPOSE 80
CMD ["apache2-foreground"]