#!/bin/bash
# Start Nginx
service nginx start

# Start PHP-FPM (stay in foreground)
php-fpm
