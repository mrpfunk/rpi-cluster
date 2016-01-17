"Download postgres":
  dockerng.image_present:
    - name: rpidockers/postgresql

/var/postgres:
  file.directory:
    - dir_mode: 755
    - makedirs: True

"Run postgres":
  dockerng.running:
    - name: postgres
    - restart_policy: always
    - image: rpidockers/postgresql
    - ports:
      - 5432/tcp
    - port_bindings:
      - 5432:5432/tcp
    - binds:
      - /var/postgres:/data
    - environment:
      - USERNAME: superuser
      - PASSWORD: password
    - require:
      - file: /var/postgres
      - dockerng: "Download postgres"

