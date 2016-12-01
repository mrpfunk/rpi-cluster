"Download crossbar":
  dockerng.image_present:
    - name: registry.flitzehack.de/crossbar

/var/docker/persistent/crossbar:
  file.directory:
    - dir_mode: 755
    - makedirs: True

"Run crossbar":
  dockerng.running:
    - name: test1.cb
    - restart_policy: always
    - detach: True
    - image: registry.flitzehack.de/crossbar
    - ports:
      - 80/tcp
    - environment:
      # - VIRTUAL_HOST: "test1.cb.{{ salt['pillar.get']('domain:name') }}"
      - VIRTUAL_HOST: "test1.cb.flitzehack.de"
    - binds:
      - /var/docker/persistent/crossbar:/node
      #- /var/docker/persistent/crossbar/.crossbar/config.json:/node/.crossbar/config.json
      #- /var/docker/persistent/crossbar/wamplets:/node/wamplets
      #- /var/docker/persistent/crossbar/log:/node/log
    # - links:
    #  - redis:redis
    - dns:
      - 192.168.2.254
    - require:
      - file: "/var/docker/persistent/crossbar"
      - dockerng: "Download crossbar"
