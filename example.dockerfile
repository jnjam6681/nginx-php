FROM jnjam6681/nginx-php:7.3-fpm

COPY database/ database/
COPY composer.json composer.lock  package*.json ./

RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist

# RUN yarn install \
#     && yarn production

RUN npm install
COPY . ./
RUN npm run prod \
    && rm -rf node_modules \
    && chown -R $USER:www-data storage \
    && chown -R $USER:www-data bootstrap/cache \
    && chmod 775 -R bootstrap/cache \
    && chmod 775 -R storage/
# COPY nginx.conf /etc/nginx/nginx.conf
# COPY vhost.conf /etc/nginx/sites-available/default.conf

# RUN php artisan optimize
# RUN php artisan migrate --force
# RUN php artisan route:cache
# RUN php artisan config:cache
# RUN php artisan view:cache
