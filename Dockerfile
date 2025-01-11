FROM fedora:39

# базовое обновление и установка всех необходимых элементов
RUN dnf update -y && dnf install -y nginx mariadb-server php-fpm php-mysqlnd && dnf clean all

# создание папок по умолчанию (если они не существуют, возникали траблы с php и mariadb)
RUN mkdir -p /etc/nginx /etc/php-fpm.d /var/www /run/php-fpm /var/lib/mysql /var/log/mysql /var/run/mysqld

# установка необходимых прав на папки
RUN chown -R nginx:nginx /var/www && chown -R nginx:nginx /run/php-fpm
RUN chown -R mysql:mysql /var/lib/mysql /var/log/mysql /var/run/mysqld

# необходима инициализация базовых таблиц
RUN mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

# нужны на один раз, потому закинем скрип и инициализацию бд через копирование
COPY ./init.sql /tmp/init.sql
RUN chmod 755 /tmp/init.sql

COPY ./start.sh /start.sh
RUN chmod +x /start.sh

# запуск пыхи в фоне и nginx не в фоне, чтобы контейнер не вырубался
# CMD ["sh", "-c", "php-fpm && nginx -g 'daemon off;'"]

# открываем доступ к контейнеру на 80 порту
EXPOSE 80

# запуск произведем через написанный скрипт, чтобы поднять все сервисы
CMD ["/start.sh"]
