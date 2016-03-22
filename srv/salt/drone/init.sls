"Download drone/drone":
  dockerng.image_present:
    - name: 'armhfbuild/drone'
    - require:
      - pip: "docker-py"

"Run drone":
  dockerng.running:
    - name: drone
    - restart_policy: always
    - image: armhfbuild/drone
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
      # - DOCKER_OPTS: '--insecure-registry 192.168.1.61:5000'
      # - VIRTUAL_HOST: 'drone.db01.freakhome.ddnss.de'
    - binds:
      - /var/run/docker.sock:/var/run/docker.sock
      - /var/lib/drone:/var/lib/drone
    - links:
      - gogs:gogs
    - dns:
      - 8.8.8.8
      - 8.8.4.4
    - require:
      - dockerng: "Download drone/drone"
