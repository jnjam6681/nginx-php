FROM jnjam6681/nginx-php:7.3-fpm

COPY database/ database/
COPY composer.json composer.lock ./

RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist

COPY . ./
# RUN yarn install \
#     && yarn production

RUN npm install \
    && npm run prod

RUN rm -rf node_modules
# COPY nginx.conf /etc/nginx/nginx.conf
# COPY vhost.conf /etc/nginx/sites-available/default.conf
# COPY --from=node /app/ /var/www/html/

# RUN php artisan optimize
# RUN php artisan migrate --force
# RUN php artisan route:cache
# RUN php artisan config:cache
# RUN php artisan view:cache
