"Download registry":
  dockerng.image_present:
    - name: registry

/var/docker/persistent/registry:
  file.directory:
    - dir_mode: 700
    - makedirs: True

"Run registry":
  dockerng.running:
    - name: registry 
    - restart_policy: always
    - image: registry
    - ports:
      - 5000/tcp
    - port_bindings:
      - 5000:5000/tcp
    # - environment:
      # - MIRROR_SOURCE_INDEX: 'https://index.docker.io'
      # - VIRTUAL_HOST: "registry.db01.{{ salt['pillar.get']('domain:name') }}"
    - binds:
      - /var/docker/persistent/registry:/tmp/registry
    - dns:
      - 8.8.8.8
      - 8.8.4.4
    - require:
      - file: /var/docker/persistent/registry
      - dockerng: "Download registry"
