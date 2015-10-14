#!/usr/bin/env bash

cd /var/www/subbly.dev/
php composer install -n
php artisan migrate --package=cartalyst/sentry
php artisan migrate
php artisan db:seed
