#!/bin/sh

/sbin/service php-fpm start
/usr/sbin/nginx

# 保持前台运行，不退出
while true
do
    sleep 100
done
