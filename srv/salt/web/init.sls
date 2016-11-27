"Download rpi-nginx":
  dockerng.image_present:
    - name: tomgeorge/rpi-nginx

"Run nginx-vhost":
  dockerng.running:
    - name: web1
    - restart_policy: always
    - detach: True
    - image: tomgeorge/rpi-nginx
    - ports:
      - 80/tcp
      - 443/tcp
    - environment:
      - VIRTUAL_HOST: "bla.db01.{{ salt['pillar.get']('domain:name') }}"
    - dns:
      - 192.168.2.254
      - 8.8.4.4
    - require:
      - dockerng: "Download rpi-nginx"
