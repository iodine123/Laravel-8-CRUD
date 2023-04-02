FROM composer:latest as build
WORKDIR /app
COPY application /app
RUN composer require fideloper/proxy
RUN composer install

FROM php:8.2.2-apache
EXPOSE 8000
COPY --from=build /app /app
COPY application/vhost.conf /etc/apache2/sites-available/laravel_app.conf
COPY application/apache2.conf /etc/apache2/apache2.conf
RUN a2dissite 000-default.conf
RUN a2enmod rewrite
RUN a2ensite laravel_app
RUN service apache2 restart
RUN php /app/artisan cache:clear
RUN php /app/artisan config:clear
RUN php /app/artisan view:clear
RUN php /app/artisan route:clear
CMD ["php", "/app/artisan", "serve"] 