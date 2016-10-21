# Nginx-Python3-Docker

use nginx and python3.5 in one container. Supervisor was also installed.
'''
$ docker pull tsumina/nginx-python3
'''

# Usage

* use your nignx and supervisor onto /etc/nginx/conf.d/nginx.conf
* override /etc/nginx/nginx.conf for main config
* override /etc/supervisor/conf.d/supervisord.conf to config supervisor
* by default, this image do nothing for you
