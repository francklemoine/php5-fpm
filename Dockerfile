FROM php:5.6.29-fpm
MAINTAINER Franck Lemoine <franck.lemoine@flem.fr>

# properly setup debian sources
ENV DEBIAN_FRONTEND=noninteractive

RUN buildDeps=' \
	   libfreetype6-dev \
	   libjpeg62-turbo-dev \
	   libmcrypt-dev \
	   libpng12-dev \
	   libbz2-dev \
	   zlib1g-dev \
	   libxslt1-dev \
	   libc-client2007e-dev \
	   libkrb5-dev \
	   libicu-dev \
	   libtidy-dev \
	   apache2-dev \
	   postgresql-server-dev-9.4 \
	' \
	set -x \
	&& apt-get -y update \
	&& apt-get -y upgrade \
	&& apt-get install -y --no-install-recommends $buildDeps \
	&& docker-php-ext-install iconv mcrypt bz2 zip ftp gettext xsl mbstring intl exif tidy \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ --with-zlib-dir=/usr/ \
	&& docker-php-ext-install gd \
	&& docker-php-ext-configure imap --with-imap-ssl --with-kerberos \
	&& docker-php-ext-install imap \
	&& docker-php-ext-install pgsql \
	&& apt-get clean autoclean \
	&& rm -f /etc/apt/apt.conf \
	&& rm -rf /var/lib/apt/lists/* \
	rm -rf /tmp/*

CMD ["php-fpm"]

