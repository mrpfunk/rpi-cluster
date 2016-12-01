"Download drone/drone":
  dockerng.image_present:
    - name: 'drone/drone'

/var/docker/persistent/drone:
  file.directory:
    - dir_mode: 755
    - makedirs: True

"Run drone":
  dockerng.running:
    - name: drone
    - restart_policy: always
    - image: drone/drone
    - hostname: drone
    - privileged: True
    - ports:
      - 8000/tcp
    - port_bindings:
      - 8000:8000/tcp
    - environment:
      - REMOTE_DRIVER: gogs
      - REMOTE_CONFIG: http://gogs:3000?open=false
      - DATABASE_DRIVER: sqlite3
      - DATABASE_CONFIG: /var/lib/drone/drone.sqlite
      # - VIRTUAL_HOST: "drone.db01.{{ salt['pillar.get']('domain:name') }}"
    - binds:
      - /var/run/docker.sock:/var/run/docker.sock
      - /var/docker/persistent/drone:/var/lib/drone
    - links:
      - gogs:gogs
    - extra_hosts:
      - gogs.flitzehack.de:192.168.2.254
      - registry.flitzehack.de:192.168.2.254
    - dns:
      - 192.168.2.254
    - require:
      - file: "/var/docker/persistent/drone"
      - dockerng: "Download drone/drone"
