#
# Install PHP Dependencies
#
FROM composer:1.7 as vendor

COPY database/ database/

COPY composer.json composer.json
COPY composer.lock composer.lock

RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist


#
# Frontend , if you using node uncomment
#
# FROM node:8.11 as frontend
# 
# RUN mkdir -p /app/public
# 
# COPY package.json webpack.mix.js yarn.lock /app/
# COPY resources/assets/ /app/resources/assets/
# 
# WORKDIR /app
# 
# RUN yarn install && yarn production

#
# Application Build
#

FROM behroozan/php-laravel:7.2
COPY . /server/http/public/
COPY --from=vendor /app/vendor/ /server/http/public/vendor/
#COPY --from=frontend /app/public/js/ /var/www/html/public/js/
#COPY --from=frontend /app/public/css/ /var/www/html/public/css/
#COPY --from=frontend /app/mix-manifest.json /var/www/html/mix-manifest.json