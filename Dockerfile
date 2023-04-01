FROM php:fpm-alpine

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/

COPY application /var/www/

EXPOSE 8000
