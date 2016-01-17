"Download postgres":
  dockerng.image_present:
    - name: joherma1/rpi-postgres

/var/postgres:
  file.directory:
    - dir_mode: 755
    - makedirs: True

"Run postgres":
  dockerng.running:
    - name: postgres
    - restart_policy: always
    - image: joherma1/rpi-postgres
    - ports:
      - 5432/tcp
    - port_bindings:
      - 5432:5432/tcp
    - binds:
      - /var/postgres:/data
    - environment:
      - POSTGRES_USERNAME: postgres
      - POSTGRES_PASSWORD: postgres
    - require:
      - file: /var/postgres
      - dockerng: "Download postgres"

