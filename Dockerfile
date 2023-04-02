FROM composer:latest as build
WORKDIR /app
COPY application /app
RUN composer require fideloper/proxy
RUN composer install

FROM php:8.2.2-apache
EXPOSE 8000
COPY --from=build /app /var/www/html/app
COPY application/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY application/apache2.conf /etc/apache2/apache2.conf
RUN a2dissite 000-default.conf
RUN a2ensite 000-default.conf
RUN a2enmod rewrite
RUN service apache2 restart
RUN php /var/www/html/app/artisan cache:clear
RUN php /var/www/html/app/artisan config:clear
RUN php /var/www/html/app/artisan view:clear
RUN php /var/www/html/app/artisan route:clear
CMD ["php", "/var/www/html/app/artisan", "serve", "--host", "127.0.0.1", "--port", "80"] 