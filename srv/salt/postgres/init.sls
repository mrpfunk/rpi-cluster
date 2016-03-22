"Download postgres":
  dockerng.image_present:
    - name: ldouchy/rpi-postgres

/var/docker/postgres:
  file.directory:
    - dir_mode: 700
    - makedirs: True

"Run postgres":
  dockerng.running:
    - name: postgres
    - restart_policy: always
    - image: ldouchy/rpi-postgres
    - ports:
      - 5432/tcp
    - port_bindings:
      - 5432:5432/tcp
    - binds:
      - /var/docker/postgres:/var/lib/postgresql/data
    - environment:
      - POSTGRES_USERNAME: postgres
      - POSTGRES_PASSWORD: {{ salt['pillar.get']('postgres:pgpass', 'postgres') }}
    - require:
      - file: /var/docker/postgres
      - dockerng: "Download postgres"
  cmd.wait:
    - name: 'echo "postgres:5432:*:postgres:{{ salt['pillar.get']('postgres:pgpass', 'postgres') }}" > /root/.pgpass && chmod 0600 /root/.pgpass' 
    - watch:
      - dockerng: "Run postgres"
   
