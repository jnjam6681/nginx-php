#
# PHP Install
#

FROM composer:1.9.0 as composer

WORKDIR /app

COPY database/ database/

COPY composer.json composer.lock ./

RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist

#
# NodeJS Install
#

FROM node:12.9.0 as node

RUN mkdir -p /app/public

WORKDIR /app

COPY package*.json webpack.mix.js yarn.lock ./
# COPY tailwind.config.js ./
COPY resources/sass/ resources/sass/
COPY resources/js/ resources/js/
# COPY resources/assets/ /app/resources/assets/

# RUN yarn install \
#     && yarn production

RUN npm install \
    && npm run pod

#
# Web Applicatiob
#

FROM jnjam6681/nginx-php:7.3-fpm

COPY --from=composer /app/vendor/ /var/www/html/vendor/
COPY --from=node /app/public/js/ /var/www/html/public/js/
COPY --from=node /app/public/css/ /var/www/html/public/css/
COPY --from=node /app/mix-manifest.json /var/www/html/mix-manifest.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY vhost.conf /etc/nginx/sites-available/default.conf
# COPY --from=node /app/ /var/www/html/

# RUN php artisan optimize
# RUN php artisan migrate --force
# RUN php artisan route:cache
# RUN php artisan config:cache
# RUN php artisan view:cache
