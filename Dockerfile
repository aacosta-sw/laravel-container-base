FROM php:7.4-apache

WORKDIR /var/www/html

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/

RUN install-php-extensions bcmath imagick xdebug zip opcache pdo_mysql
# Laravel CLI, MySQL, Composer, and NPM

RUN apt-get update && apt-get -y install curl npm

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer global require laravel/installer

RUN PATH="/root/.composer:$PATH"

EXPOSE 80