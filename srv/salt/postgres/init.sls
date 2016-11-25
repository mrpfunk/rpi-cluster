"Download postgres":
  dockerng.image_present:
    - name: postgres

/var/docker/postgres:
  file.directory:
    - dir_mode: 700
    - makedirs: True

/var/docker/persistent/pg:
  file.directory:
    - dir_mode: 700
    - makedirs: True

"Run postgres":
  dockerng.running:
    - name: postgres
    - restart_policy: always
    - image: postgres
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
      - file: /var/docker/persistent/pg
      - dockerng: "Download postgres"
  cmd.wait:
    - name: 'echo "postgres:5432:*:postgres:{{ salt['pillar.get']('postgres:pgpass', 'postgres') }}" > /var/docker/persistent/pg/.pgpass && chmod 0600 /var/docker/persistent/pg/.pgpass' 
    - watch:
      - dockerng: "Run postgres"
   
