FROM ubuntu:20.04


ENV DEBIAN_FRONTEND=noninteractive 

ENV TZ=Europe/Istanbul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update

RUN apt install -y wget curl
RUN apt-get update -y
RUN apt install -y curl wget php php-fpm php-mysql \
        php-common php-cli php-common \
        php-opcache php-readline \
        php-mbstring php-xml php-gd php-curl

RUN cd /bin && wget "http://stedolan.github.io/jq/download/linux64/jq" && chmod 755 jq


RUN apt install nginx -y

COPY wp-config.php /var/www/html
COPY conf/default /etc/nginx/sites-enabled/default
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY ./entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh
EXPOSE 80
# USER www-data
ENTRYPOINT [ "bash", "./entrypoint.sh" ]