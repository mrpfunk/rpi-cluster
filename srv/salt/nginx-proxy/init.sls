"Download nginx-proxy":
  dockerng.image_present:
    - name: bestlibre/rpi-nginx-proxy:bin
    - require:
      - pip: "docker-py"

"Run nginx-proxy":
  dockerng.running:
    - name: nginx-proxy
    - restart_policy: always
    - image: bestlibre/rpi-nginx-proxy:bin
    - ports:
      - 80/tcp
    - port_bindings:
      - 80:80/tcp
    - binds:
      - /var/run/docker.sock:/tmp/docker.sock
    - require:
      - dockerng: "Download nginx-proxy"

