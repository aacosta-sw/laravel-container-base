FROM php:7.4-apache

WORKDIR /var/www/html

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/

RUN install-php-extensions bcmath imagick xdebug zip opcache pdo_mysql
# Laravel CLI, MySQL, Composer, and NPM

RUN apt-get update && apt-get -y install curl npm unzip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Export composer vendor path
RUN echo "" >> ~/.bashrc && \
    echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> ~/.bashrc

RUN composer global require laravel/installer

EXPOSE 80