FROM php:8.2-fpm-alpine

# Install any additional PHP extensions, e.g.:
# RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www

COPY . /var/www

CMD ["php", "-S", "0.0.0.0:8080", "-t", "public"]
