FROM centos:7
ENV container=docker
LABEL maintainer="397136899@qq.com"


RUN yum -y update; yum clean all
RUN yum -y install net-tools zip unzip gcc gcc-c++ python wget git yum-utils supervisor socat vim which
RUN yum -y install logrotate

RUN mkdir -p /install
WORKDIR /install

# COPY packages/oneinstack-full.tar.gz /install
# RUN tar xzf oneinstack-full.tar.gz 

RUN yum -y install  https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum -y install  http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum -y install  http://www.rabbitmq.com/releases/erlang/erlang-19.0.4-1.el7.centos.x86_64.rpm
RUN yum -y install  http://www.rabbitmq.com/releases/rabbitmq-server/v3.6.14/rabbitmq-server-3.6.14-1.el7.noarch.rpm

RUN yum-config-manager --enable remi-php72
RUN yum -y update
RUN yum -y install php72 php72-php-common php72-php-opcache php72-php-mcrypt php72-php-cli php72-php-curl php72-php-redis php72-php-memcached php72-php-imagick php72-php-fileinfo php72-php-mysqlnd php72-php-fpm phpmyadmin
RUN yum -y install nginx mysql telnet netcat php-fpm
RUN yum -y install php72-php-xml php72-php-mbstring  php72-php-gd php72-php-zip
RUN yum -y install crontabs cronie
RUN yum clean all
ENV PATH="/opt/remi/php72/root/usr/bin:${PATH}"
RUN echo "* * * * * . /etc/profile;/opt/remi/php72/root/usr/bin/php /data/wwwroot/outbook/artisan schedule:run >> /dev/null 2>&1" >> /etc/crontab

RUN php72 -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" 
RUN php72 composer-setup.php
RUN mv composer.phar /usr/local/bin/composer



STOPSIGNAL SIGTERM

WORKDIR /data/wwwroot

HEALTHCHECK --interval=5m --timeout=3s \
     CMD curl -f http://localhost:82/ || exit 1

VOLUME ["/data", "/etc/nginx", "/etc/rabbitmq/rabbitmq.config", "/var/log", "/etc/php.ini", "/etc/php-fpm.d", "/etc/phpMyAdmin"]
EXPOSE 80 82 8080


ENTRYPOINT sh /data/script/startup.sh 