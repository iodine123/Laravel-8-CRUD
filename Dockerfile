FROM composer:latest as build

WORKDIR /app
COPY . /app
RUN composer require fideloper/proxy
RUN composer install

FROM php:8.2.2-apache

RUN docker-php-ext-install pdo pdo_mysql
COPY --from=build /app /var/www/html
COPY ./apache2.conf /etc/apache2/apache2.conf
RUN chmod -R 775 /var/www/html
RUN chown -R user:group /path/to/webroot/directory
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN a2enmod rewrite
EXPOSE 80
CMD ["apache2-foreground"]