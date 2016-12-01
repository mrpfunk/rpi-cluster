"Download gogs/gogs":
  dockerng.image_present:
    - name: 'gogs/gogs'

/var/docker/persistent/gogs:
  file.directory:
    - dir_mode: 755
    - makedirs: True

"Run gogs":
  dockerng.running:
    - name: gogs
    - restart_policy: always
    - image: gogs/gogs
    - ports:
      - 22/tcp
      - 3000/tcp
    - binds:
      - /var/docker/persistent/gogs:/data
    - port_bindings:
      - 3000:3000/tcp
    - links:
      - postgres:postgres
   # - extra_hosts:
   #   - drone.flitzehack.de:192.168.2.254
    - dns:
      - 192.168.2.254
    - require:
      - file: "/var/docker/persistent/gogs"
      - dockerng: "Download gogs/gogs"

# sudo docker run -it --link postgres:postgres --rm postgres sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres'
# CREATE USER gogs WITH PASSWORD 'gogs';
# CREATE DATABASE gogs OWNER gogs;
# GRANT ALL PRIVILEGES ON DATABASE gogs TO gogs;
# or as a one liner:
# CREATE USER gogs WITH PASSWORD 'gogs'; CREATE DATABASE gogs OWNER gogs; GRANT ALL PRIVILEGES ON DATABASE gogs TO gogs;
