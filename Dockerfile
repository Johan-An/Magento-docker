#
#--------------------------------------------------------------------------
# Image Setup
#--------------------------------------------------------------------------
#

FROM phusion/baseimage:focal-1.0.0

LABEL io.laradock.image.authors="Mahm1oud Zalt <mahmoud@zalt.me>"
LABEL io.laradock.image.authors="Thomas Combe <tcombe@webqam.fr>"

ENV DEBIAN_FRONTEND=noninteractive
RUN locale-gen en_US.UTF-8

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV TERM xterm

RUN set -eux \
    # Add the "PHP 8" ppa
    && apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:ondrej/php \
    #
    #--------------------------------------------------------------------------
    # Software's Installation
    #--------------------------------------------------------------------------
    #
    && echo 'DPkg::options { "--force-confdef"; };' >> /etc/apt/apt.conf \
    # Install "PHP Extentions", "libraries", "Software's"
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --allow-downgrades --allow-remove-essential \
        --allow-change-held-packages \
        php8.2-cli \
        php8.2-common \
        php8.2-curl \
        php8.2-intl \
        php8.2-xml \
        php8.2-mbstring \
        php8.2-mysql \
        php8.2-pgsql \
        php8.2-sqlite \
        php8.2-sqlite3 \
        php8.2-zip \
        php8.2-bcmath \
        php8.2-memcached \
        php8.2-gd \
        php8.2-dev \
        php8.2-soap \
        pkg-config \
        libcurl4-openssl-dev \
        libedit-dev \
        libssl-dev \
        libxml2-dev \
        xz-utils \
        libsqlite3-dev \
        rsync \
        sqlite3 \
        git \
        curl \
        vim \
        nano \
        tree \
        postgresql-client \
    && apt-get clean \
    #####################################
    # Composer:
    #####################################
    # Install composer and add its bin to the PATH.
    && curl -s http://getcomposer.org/installer | php \
    && echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc \
    && mv composer.phar /usr/local/bin/composer