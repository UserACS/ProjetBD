FROM php:8.2-fpm-alpine

WORKDIR /var/www

RUN apk add --no-cache php8-mbstring php8-xml php8-bcmath php8-curl php8-tokenizer php8-ctype php8-json php8-openssl php8-session php8-pdo php8-pdo_mysql php8-fileinfo php8-zip

COPY . .

RUN composer install --no-dev --optimize-autoloader
RUN php artisan key:generate
RUN php artisan migrate --force

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
