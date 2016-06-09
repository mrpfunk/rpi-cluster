"Download rpi-crossbar":
  dockerng.image_present:
    - name: registry.flitzehack.de/rpi-crossbar

"Run rpi-crossbar":
  dockerng.running:
    - name: c1
    - restart_policy: always
    - detach: True
    - image: registry.flitzehack.de/rpi-crossbar
    - ports:
      - 80/tcp
      - 443/tcp
    - environment:
      - VIRTUAL_HOST: "c1.db01.{{ salt['pillar.get']('domain:name') }}"
    - dns:
      - 8.8.8.8
      - 8.8.4.4
    - require:
      - dockerng: "Download rpi-crossbar"
