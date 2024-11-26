FROM debian

RUN apt-get update

RUN apt-get update && apt-get install -y nginx

COPY ./ /var/www/html/

CMD ["nginx", "-g", "daemon off;"]
