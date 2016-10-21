FROM python:3.5

MAINTAINER Tsumina <f0230074@gmail.com>

# Standard set up Nginx
ENV NGINX_VERSION 1.11.5-1~jessie

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
	&& echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
						ca-certificates \
						nginx=${NGINX_VERSION} \
						nginx-module-xslt \
						nginx-module-geoip \
						nginx-module-image-filter \
						nginx-module-perl \
						nginx-module-njs \
						gettext-base \
	&& rm -rf /var/lib/apt/lists/*

# Install Supervisord
RUN apt-get update && apt-get install -y supervisor \
&& rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

# proxy temp path
RUN mkdir -p /home/nginx/proxy_temp

# Copy the modified Nginx conf
COPY nginx.conf /etc/nginx/nginx.conf

# Remove default configuration from Nginx
RUN rm /etc/nginx/conf.d/default.conf

EXPOSE 80 443
# ========================finish setting nginx=======================

# Custom Supervisord config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#===================================================
RUN echo "Welcome to use nginx-python3 docker"
RUN echo "RUN Supervisor with /usr/bin/supervisord"
RUN echo "See README for usage"
