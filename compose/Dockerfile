FROM centos:7
ENV container=docker
ARG dbrootpwd=Geinshow2019
ARG secondary_domain=csaz.outbook.cc
LABEL maintainer="397136899@qq.com"

EXPOSE 80

RUN yum -y update; yum clean all
RUN yum -y install net-tools zip unzip gcc gcc-c++ python wget git yum-utils supervisor socat

RUN mkdir -p /install
WORKDIR /install

COPY packages/epel-release-latest-7.noarch.rpm /install
COPY packages/erlang-19.0.4-1.el7.centos.x86_64.rpm /install
COPY packages/rabbitmq-server-3.6.14-1.el7.noarch.rpm /install
COPY packages/oneinstack-full.tar.gz /install

RUN yum -y install logrotate

RUN rpm -Uvh epel-release-latest-7.noarch.rpm
RUN rpm -ivh erlang-19.0.4-1.el7.centos.x86_64.rpm
RUN rpm -ivh rabbitmq-server-3.6.14-1.el7.noarch.rpm


RUN yum-config-manager --enable remi-php72
RUN yum -y install php php-common php-opcache php-mcrypt php-cli php-curl php-redis php-memcached php-imagick php-fileinfo php-mysqlnd
RUN yum -y install phpmyadmin

RUN yum -y install nginx

RUN yum -y install mysql telnet netcat

RUN php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" 
RUN php composer-setup.php
RUN mv composer.phar /usr/local/bin/composer



RUN tar xzf oneinstack-full.tar.gz 


COPY mount/etc/rabbitmq/rabbitmq.config /etc/rabbitmq

VOLUME ["/data", "/var/log/rabbitmq", "/sys/fs/cgroup"]

STOPSIGNAL SIGTERM

HEALTHCHECK --interval=5m --timeout=3s \
     CMD curl -f http://localhost/ || exit 1

ENTRYPOINT sh /data/script/startup.sh 
# ENTRYPOINT sh


# CMD ["/usr/sbin/init"]