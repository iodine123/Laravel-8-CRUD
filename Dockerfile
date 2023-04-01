FROM php:fpm-alpine

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/

COPY application /var/www/

EXPOSE 8000

RUN php artisan key:generate

RUN /bin/sh -c composer install

CMD php artisan serve --host=0.0.0.0 --port=8000

