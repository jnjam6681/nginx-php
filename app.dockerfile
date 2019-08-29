FROM intranet/app

COPY . /var/www/html/

WORKDIR /var/www/html

# configure nginx
# RUN rm /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/nginx.conf

# setup sites-available
COPY vhost.conf /etc/nginx/sites-available/default.conf

RUN composer install

# RUN npm install
#
# RUN yarn install && yarn run prod
# RUN php artisan optimize
#
# RUN php artisan migrate
#
# RUN php artisan route:cache
#
# RUN php artisan config:cache
#
# RUN php artisan view:cache
