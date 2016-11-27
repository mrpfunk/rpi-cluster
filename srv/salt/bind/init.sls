"Download bind":
  dockerng.image_present:
    - name: 'sameersbn/bind'

/var/docker/persistent/bind:
  file.directory:
    - dir_mode: 755
    - makedirs: True

"Run bind":
  dockerng.running:
    - name: bind
    - restart_policy: always
    - image: sameersbn/bind
    - ports:
      - 53/udp
      - 53/tcp
      - 10000/tcp
    - binds:
      - /var/docker/persistent/bind:/data
    - port_bindings:
      - 53:53/tcp
      - 53:53/udp
      - 10000:10000/tcp
    - dns:
      - 8.8.8.8
      - 8.8.4.4
    - require:
      - file: "/var/docker/persistent/bind"
      - dockerng: "Download bind"
