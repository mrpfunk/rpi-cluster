"Download rpi-nginx":
  dockerng.image_present:
    - name: tomgeorge/rpi-nginx
    - require:
      - pip: "docker-py"

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
      - VIRTUAL_HOST: 'bla.db01.freakhome.ddnss.de'
    - dns:
      - 8.8.8.8
      - 8.8.4.4
    - require:
      - dockerng: "Download rpi-nginx"
