# Use official PHP 8.0 FPM image
FROM php:8.0-fpm

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    libpq-dev \
    unzip \
    git \
    curl \
    nginx \
    && docker-php-ext-install pdo pdo_pgsql pgsql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Composer globally
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy project files
COPY . .

# Install PHP dependencies (without dev packages)
RUN composer install --no-dev --optimize-autoloader

# Set correct permissions for Laravel folders
RUN chown -R www-data:www-data storage bootstrap/cache

# Copy Nginx configuration file
COPY ./nginx.conf /etc/nginx/sites-enabled/default

# Copy start script and make it executable
COPY ./start.sh /start.sh
RUN chmod +x /start.sh

# Expose port 8080 for web traffic
EXPOSE 8080

# Run Nginx and PHP-FPM together
CMD ["/start.sh"]
