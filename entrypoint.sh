#!/bin/sh

# تشغيل المايجريشنز تلقائيًا بدون تأكيد
php artisan migrate --force

# بدء خادم php-fpm
php-fpm
