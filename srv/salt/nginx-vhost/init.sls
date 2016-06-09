"Download rpi-nginx":
  dockerng.image_present:
    - name: tomgeorge/rpi-nginx
    - require:
      - pip: "docker-py"

"Run nginx-vhost":
  dockerng.running:
    - name: nginx-vhost
    - restart_policy: always
    - image: tomgeorge/rpi-nginx
    - ports:
      - 80/tcp
      - 443/tcp
    - binds:
      - /var/docker/persistent/nginx-vhost/default.conf:/etc/nginx/conf.d/default.conf:ro
      - /var/docker/persistent/nginx-vhost/ssl/certs:/etc/nginx/ssl:ro
      - /var/docker/persistent/nginx-vhost/ssl/dhparam.pem:/etc/nginx/dhparam.pem:ro
      - /var/docker/persistent/nginx-vhost/nginx.conf:/etc/nginx/nginx.conf:ro
      - /var/docker/persistent/nginx-vhost/root:/usr/share/nginx/html:ro
    - port_bindings:
      - 80:80/tcp
      - 443:443/tcp
    - dns:
      - 8.8.8.8
      - 8.8.4.4
    - require:
      - dockerng: "Download rpi-nginx"
