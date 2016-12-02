"Download crossbar":
  dockerng.image_present:
    - name: registry.flitzehack.de/crossbar


"Run crossbar":
  dockerng.running:
    - name: test1.cb
    # - restart_policy: always
    - detach: True
    - image: registry.flitzehack.de/crossbar
    - ports:
      - 80/tcp
    - environment:
      # - VIRTUAL_HOST: "test1.cb.{{ salt['pillar.get']('domain:name') }}"
      - VIRTUAL_HOST: "test1.cb.flitzehack.de"
    - binds:
      - /home/mnowak/src/crossbar/node:/node/.crossbar
      - /home/mnowak/src/ap:/node/web
      - /home/mnowak/src/wamplets3:/node/wamplets
    - links:
      - redis:redis
    - dns:
      - 192.168.2.254
    - require:
      - dockerng: "Download crossbar"
