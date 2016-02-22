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
      - /srv/salt/nginx-vhost/default.conf:/etc/nginx/conf.d/default.conf:ro
      # - /srv/salt/nginx-vhost/ssl:/etc/nginx/ssl:ro
      - /srv/salt/nginx-vhost/nginx.conf:/etc/nginx/nginx.conf:ro
      - /srv/salt/nginx-vhost/root:/usr/share/nginx/html:ro
    - port_bindings:
      - 80:80/tcp
      - 443:443/tcp
    - dns:
      - 8.8.8.8
      - 8.8.4.4
    - require:
      - dockerng: "Download rpi-nginx"
