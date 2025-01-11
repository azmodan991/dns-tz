#!/bin/bash

# установка прав на папки (на случай, если они были изменены(один раз почему-то у меня такое произошло, сейчас все вроде отрабывает норм, но пусть останется))
chown -R mysql:mysql /var/lib/mysql /var/log/mysql /var/run/mysqld

# MariaDB
echo "Starting MariaDB..." # чтобы красиво в логе было
mysqld_safe --datadir=/var/lib/mysql --socket=/var/lib/mysql/mysql.sock --user=mysql --pid-file=/var/run/mysqld/mysqld.pid --basedir=/usr --log-error=/var/log/mysql/error.log &
sleep 10  # Ждём, пока MariaDB запустится

# Инициализация базы данных
echo "Initializing database..." # чтобы красиво в логе было
mysql -u root -e "CREATE DATABASE IF NOT EXISTS test_db;" # также свой костыльный обработчик на всякий случай
mysql -u root test_db < /tmp/init.sql 			  # выполнение скрипта для заполнения бд

# PHP-FPM
echo "Starting PHP-FPM..." # чтобы красиво в логе было
php-fpm &

# nginx
echo "Starting Nginx..." # чтобы красиво в логе было
nginx -g 'daemon off;'
