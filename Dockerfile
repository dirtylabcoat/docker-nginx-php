FROM alpine:3.12.0
ENV WEBROOT_DIR=/www
RUN apk --no-cache add nginx \
    && apk add php7 php7-fpm php7-opcache \
    && apk add php7-gd php7-zlib php7-curl composer \
    && mkdir /run/nginx && chown nginx:nginx /run/nginx \
    && mkdir ${WEBROOT_DIR} && chown nginx:nginx ${WEBROOT_DIR} \
    && rm -rf /var/cache/apk/* ${WEBROOT_DIR}/*

RUN echo "<html><body>meh</body></html>" > ${WEBROOT_DIR}/index.html

COPY etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY etc/nginx/common.conf /etc/nginx/common.conf
COPY etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
