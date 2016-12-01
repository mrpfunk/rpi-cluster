"Download nginx-proxy":
  dockerng.image_present:
    - name: jwilder/nginx-proxy

"Run nginx-proxy":
  dockerng.running:
    - name: nginx-proxy
    - restart_policy: always
    - image: jwilder/nginx-proxy
    - ports:
      - 80/tcp
    - port_bindings:
      - 81:80/tcp
    - binds:
      - /var/run/docker.sock:/tmp/docker.sock:ro
    - require:
      - dockerng: "Download nginx-proxy"

