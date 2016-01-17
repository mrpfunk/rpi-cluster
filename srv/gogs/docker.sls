"Download gogs/gogs":
  dockerng.image_present:
    - name: 'hypriot/rpi-gogs-raspbian'
    - require:
      - pip: "docker-py"

/var/gogs:
  file.directory:
    - dir_mode: 755
    - makedirs: True

"Run gogs":
  dockerng.running:
    - name: gogs
    - restart_policy: always
    - image: hypriot/rpi-gogs-raspbian
    - hostname: gogs
    - ports:
      - 22/tcp
      - 3000/tcp
    - binds:
      - /var/gogs:/data
    - port_bindings:
      - 3000:3000/tcp
    - dns:
      - 8.8.8.8
      - 8.8.4.4
    - require:
      - file: "/var/gogs"
      - dockerng: "Download gogs/gogs"
