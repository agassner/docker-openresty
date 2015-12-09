FROM debian:jessie

ENV DEBIAN_FRONTEND=noninteractive

RUN \
  apt-get update && apt-get install -y \
  build-essential \
  curl \
  wget \
  perl \
  libreadline-dev \
  libncurses5-dev \
  libpcre3-dev \
  libssl-dev \
  libxslt1-dev \
  libgd2-xpm-dev \
  libgeoip-dev

RUN \
  wget https://openresty.org/download/ngx_openresty-1.9.3.2.tar.gz && \
  tar -xzvf ngx_openresty-*.tar.gz && \
  rm -f ngx_openresty-*.tar.gz && \
  cd ngx_openresty-* && \
  ./configure \
    --with-luajit \
    --with-debug \
    --with-pcre-jit \
    --with-ipv6 \
    --with-http_ssl_module \
    --with-http_stub_status_module \
    --with-http_realip_module \
    --with-http_addition_module \
    --with-http_dav_module \
    --with-http_geoip_module \
    --with-http_gzip_static_module \
    --with-http_image_filter_module \
    --with-http_spdy_module \
    --with-http_sub_module && \
  make && \
  make install && \
  make clean && \
  cd .. && \
  rm -rf ngx_openresty-*&& \
  ln -s /usr/local/openresty/nginx/sbin/nginx /usr/local/bin/nginx && \
  ldconfig

RUN mkdir -p /var/log/nginx
RUN ln -s /usr/local/openresty/nginx/conf /etc/nginx
ADD ./config/nginx.conf /etc/nginx/

CMD ["nginx", "-c", "/etc/nginx/nginx.conf"]