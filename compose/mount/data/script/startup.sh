#!/bin/bash 
set -x

rabbitmq-server start -detached
rabbitmq-plugins enable rabbitmq_management
rabbitmq-plugins enable rabbitmq_top

# redis-server --daemonize yes
# /usr/bin/memcached -d

nginx -g "daemon off;"