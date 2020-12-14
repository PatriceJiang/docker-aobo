#!/bin/bash 
set -x
scl enable php72 bash

# Start rabbitmq 
rabbitmq-server start -detached
# Waiting for rabbitmq...
sleep 3
rabbitmq-plugins enable rabbitmq_management
rabbitmq-plugins enable rabbitmq_top

# Start php-fpm 
php-fpm -c /etc -D
# start cron server
crond 
nginx -g "daemon off;"