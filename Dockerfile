FROM php:8.0-apache
LABEL version="0.2.3"

# Configure Apache
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY start-apache /usr/local/bin
RUN a2enmod rewrite

# Copy FOSSBilling to the container and change the owner of the files
COPY src /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Install the PDO extension
RUN docker-php-ext-configure pdo_mysql \
	&& docker-php-ext-install -j$(nproc) pdo_mysql

CMD ["start-apache"]