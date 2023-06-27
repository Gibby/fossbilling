FROM php:8.1-apache
LABEL version="0.5.2"

RUN apt update; \
apt install -y --no-install-recommends wget unzip zlib1g-dev libpng-dev libicu-dev;
    
# Configure Apache
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY start-apache /usr/local/bin
RUN a2enmod rewrite

# Download from Github
RUN set -eux; \
	version="0.5.2"; \
	wget https://github.com/FOSSBilling/FOSSBilling/releases/download/$version/FOSSBilling.zip; \
	unzip FOSSBilling.zip -d /var/www/html
# Copy FOSSBilling to the container and change the owner of the file

RUN chown -R www-data:www-data /var/www/html
RUN rm /var/www/html/FOSSBilling.zip

# Install the PDO extension
RUN docker-php-ext-configure pdo_mysql \
	&& docker-php-ext-install -j$(nproc) pdo_mysql \
	&& docker-php-ext-configure gd \
	&& docker-php-ext-install -j$(nproc) gd \
	&& docker-php-ext-configure intl \
	&& docker-php-ext-install -j$(nproc) intl

CMD ["start-apache"]
