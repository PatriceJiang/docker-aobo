#!/bin/bash 
set -x
scl enable php72 bash
rabbitmq-server start -detached
sleep 3
rabbitmq-plugins enable rabbitmq_management
rabbitmq-plugins enable rabbitmq_top

php-fpm -c /etc -D
crond 
# redis-server --daemonize yes
# /usr/bin/memcached -d

nginx -g "daemon off;"