FROM php:8.2-fpm-alpine

WORKDIR /var/www

RUN apk add --no-cache \
    curl \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    oniguruma-dev \
    zip \
    unzip \
    bash

# Installer les extensions PHP via "docker-php-ext-install"
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd mbstring pdo pdo_mysql tokenizer xml zip bcmath

COPY . .

RUN composer install --no-dev --optimize-autoloader
RUN php artisan key:generate
RUN php artisan migrate --force

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
