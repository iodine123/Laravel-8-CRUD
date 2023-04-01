FROM composer:latest as build
WORKDIR /app
COPY application /app
RUN composer install

FROM php:7.1.8-apache
EXPOSE 80
COPY --from=build /app /app
COPY application/vhost.conf /etc/apache2/sites-available/000-default.conf
RUN chown -R www-data:www-data /app a2enmod rewrite