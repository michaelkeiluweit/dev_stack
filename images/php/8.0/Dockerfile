FROM php:8.0-fpm

# install dependencies and cleanup (needs to be one step, as else it will cache in the laver)
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    git msmtp default-mysql-client iproute2 libfreetype6 libjpeg62-turbo libcurl4-openssl-dev libjpeg-dev libpng-dev libxml2-dev libmemcached-dev libzip-dev libonig-dev sudo && \
    pecl install xdebug memcached && \
    docker-php-ext-enable xdebug && \
    docker-php-ext-configure gd --with-jpeg && \
    docker-php-ext-install -j$(nproc) zip bcmath soap pdo_mysql gd mysqli && \
    apt-get clean && \
    apt-get autoremove -y && \
    apt-get purge -y --auto-remove libcurl4-openssl-dev libjpeg-dev libpng-dev libxml2-dev libmemcached-dev && \
    rm -rf /var/lib/apt/lists/*

# configure PHP
RUN touch /usr/local/etc/php/conf.d/php.ini; \
    echo memory_limit=-1 >> /usr/local/etc/php/conf.d/php.ini; \
    echo max_execution_time=0 >> /usr/local/etc/php/conf.d/php.ini; \
    echo error_reporting = E_ALL >> /usr/local/etc/php/conf.d/php.ini; \
    echo log_errors = On >> /usr/local/etc/php/conf.d/php.ini; \
    echo error_log = /proc/self/fd/2 >> /usr/local/etc/php/conf.d/php.ini;

# configure xdebug & timezone
RUN touch /usr/local/etc/php/conf.d/xdebug.ini; \
    echo xdebug.mode = debug                       >> /usr/local/etc/php/conf.d/xdebug.ini; \
    echo xdebug.start_with_request = trigger       >> /usr/local/etc/php/conf.d/xdebug.ini; \
    echo xdebug.trigger_value = "XDEBUG_PROFILE"   >> /usr/local/etc/php/conf.d/xdebug.ini; \
    echo xdebug.discover_client_host = 1           >> /usr/local/etc/php/conf.d/xdebug.ini; \
    echo xdebug.client_host = host.docker.internal >> /usr/local/etc/php/conf.d/xdebug.ini; \
    echo xdebug.client_port = 9005                 >> /usr/local/etc/php/conf.d/xdebug.ini; \
    echo xdebug.idekey = PHPSTORM                  >> /usr/local/etc/php/conf.d/xdebug.ini; \
    echo xdebug.remote_handler = dbgp              >> /usr/local/etc/php/conf.d/xdebug.ini; \ 
    echo xdebug.output_dir = /var/www/html/        >> /usr/local/etc/php/conf.d/xdebug.ini; \
    echo date.timezone = Europe/Berlin             >> /usr/local/etc/php/conf.d/timezone.ini

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# set up mailhog as sendmail target
RUN echo "host mailhog" >> /etc/msmtprc
RUN echo "port 1025" >> /etc/msmtprc
RUN echo "sendmail_path=/usr/bin/msmtp -t" >> /usr/local/etc/php/conf.d/php-sendmail.ini

RUN export PHP_IDE_CONFIG="serverName=Docker"
