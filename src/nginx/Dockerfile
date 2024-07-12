FROM nginx:latest

# Устанавливаем рабочую директорию
WORKDIR /home/

# Копируем необходимые файлы
COPY ./main.c . 
COPY ./start_server.sh . 
COPY ./nginx.conf /etc/nginx/nginx.conf 

# Устанавливаем необходимые пакеты и выполняем настройки под root
USER root
RUN apt-get update && \
    apt-get install -y gcc spawn-fcgi libfcgi-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -m mini_serv && \
    chown -R mini_serv:mini_serv /etc/nginx/nginx.conf /var/cache/nginx /home && \
    touch /var/run/nginx.pid && \
    chown -R mini_serv:mini_serv /var/run/nginx.pid && \
    chmod u-s /usr/bin/gpasswd /usr/bin/chsh /usr/bin/chfn /usr/bin/expiry /usr/bin/passwd /sbin/unix_chkpwd /usr/bin/chage /usr/bin/wall /bin/umount /bin/mount /usr/bin/newgrp /bin/su

# Переходим на пользователя mini_serv
USER mini_serv

# Проверка состояния сервера
HEALTHCHECK CMD curl --fail http://localhost:81/ || exit 1

# Запускаем скрипт для старта сервера
ENTRYPOINT ["bash", "./start_server.sh"]
