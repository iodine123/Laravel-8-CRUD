FROM php:8.1-apache

WORKDIR /var/www/html

RUN docker-php-ext-install pdo pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY application .

RUN composer install --no-interaction --no-scripts --prefer-dist --optimize-autoloader

COPY ./application/apache2.conf /etc/apache2/apache2.conf

RUN a2enmod rewrite

ENV APACHE_DOCUMENT_ROOT /var/www/html/public

EXPOSE 80

CMD ["apache2-foreground"]
