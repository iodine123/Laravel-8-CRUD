FROM ubuntu:latest

WORKDIR /app/src

COPY . .

RUN apt-get -y update

RUN apt install -y apache2

RUN apt install -y php libapache2-mod-php php-mbstring php-xmlrpc php-soap php-gd php-xml php-cli php-zip php-bcmath php-tokenizer php-json php-pear

RUN curl -sS https://getcomposer.org/installer | php

RUN php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN mv composer.phar /usr/local/bin/composer

RUN chmod +x /usr/local/bin/composer

RUN composer update

RUN composer install

RUN php artisan cache:clear
RUN php artisan config:clear
RUN php artisan view:clear
RUN php artisan key:generate
RUN php artisan route:clear
RUN php artisan serve --host=127.0.0.1 --port=80
