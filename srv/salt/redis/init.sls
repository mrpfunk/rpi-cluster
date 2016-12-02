"Download redis":
  dockerng.image_present:
    - name: 'redis'

/var/docker/persistent/redis:
  file.directory:
    - dir_mode: 755
    - makedirs: True

"Run redis":
  dockerng.running:
    - name: redis
    - restart_policy: always
    - image: redis
    - ports:
      - 6379/tcp
    - binds:
      - /var/docker/persistent/redis:/data
    - dns:
      - 192.168.2.254
    - require:
      - file: "/var/docker/persistent/redis"
      - dockerng: "Download redis"
