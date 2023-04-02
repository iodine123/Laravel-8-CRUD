
FROM php:8.1-fpm

RUN docker-php-ext-install pdo pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

COPY application .

COPY .git .

RUN composer install --no-interaction --no-scripts --prefer-dist --optimize-autoloader

COPY /application/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["sh", "-c", "service php8.1-fpm start && nginx -g 'daemon off;'"]