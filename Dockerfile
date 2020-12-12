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
COPY packages/remi-release-7.rpm /install
COPY packages/erlang-19.0.4-1.el7.centos.x86_64.rpm /install
COPY packages/rabbitmq-server-3.6.14-1.el7.noarch.rpm /install
COPY packages/oneinstack-full.tar.gz /install

RUN yum -y install logrotate

RUN rpm -Uvh epel-release-latest-7.noarch.rpm
RUN rpm -Uvh remi-release-7.rpm
RUN rpm -ivh erlang-19.0.4-1.el7.centos.x86_64.rpm
RUN rpm -ivh rabbitmq-server-3.6.14-1.el7.noarch.rpm

RUN yum -y install systemd
RUN yum clean all
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

WORKDIR /install

RUN tar xzf oneinstack-full.tar.gz 
# RUN sh ./oneinstack/install.sh --nginx_option 1 --php_option 7 --phpcache_option 1 --php_extensions imagick,fileinfo,redis,memcached --phpmyadmin --db_option 2 --dbinstallmethod 1 --dbrootpwd $dbrootpwd --redis --memcached --iptables --reboot
RUN sh ./oneinstack/install.sh --nginx_option 1 --php_option 7 --phpcache_option 1 --php_extensions imagick,fileinfo,redis,memcached --phpmyadmin  --pureftpd 
COPY mount/etc/rabbitmq/rabbitmq.config /etc/rabbitmq

VOLUME ["/data"]
VOLUME ["/sys/fs/cgroup"]

HEALTHCHECK --interval=5m --timeout=3s \
     CMD curl -f http://localhost/ || exit 1

# ENTRYPOINT sh /data/script/startup.sh 
ENTRYPOINT sh


# CMD ["/usr/sbin/init"]