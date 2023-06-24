FROM php:8.2-apache

# Sets the document root director for the webserver to 'public/'
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# install dependencies and cleanup (needs to be one step, as else it will cache in the laver)
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    git iproute2 libcurl4-openssl-dev libxml2-dev libzip-dev zip unzip sudo && \
    pecl install xdebug && \
    docker-php-ext-enable xdebug && \
    #docker-php-ext-install -j$(nproc) curl json xml mbstring zip bcmath soap && \
    apt-get clean && \
    apt-get autoremove -y && \
    apt-get purge -y --auto-remove libcurl4-openssl-dev libjpeg-dev libpng-dev libxml2-dev libmemcached-dev && \
    rm -rf /var/lib/apt/lists/*
    
# configure PHP
RUN touch /usr/local/etc/php/conf.d/php.ini && \
    echo "date.timezone = Europe/Berlin" >> /usr/local/etc/php/conf.d/timezone.ini && \
    echo "memory_limit = -1" >> /usr/local/etc/php/conf.d/php.ini && \
    echo "max_execution_time = 0" >> /usr/local/etc/php/conf.d/php.ini && \
    echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/php.ini && \
    echo "log_errors = On" >> /usr/local/etc/php/conf.d/php.ini && \
    echo "error_log = /dev/null" >> /usr/local/etc/php/conf.d/php.ini && \
    echo "xdebug.mode = debug" >> /usr/local/etc/php/conf.d/php.ini && \
    echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/php.ini && \
    echo "xdebug.client_port = 9003" >> /usr/local/etc/php/conf.d/php.ini && \
    echo "xdebug.start_with_request = yes" >> /usr/local/etc/php/conf.d/php.ini && \
    echo "xdebug.output_dir = /var/www/html/log/" >> /usr/local/etc/php/conf.d/php.ini && \
    echo "xdebug.log = /dev/null" >> /usr/local/etc/php/conf.d/php.ini

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
