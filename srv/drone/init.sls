"Download drone/drone":
  dockerng.image_present:
    - name: 'hypriot/rpi-drone'
    - require:
      - pip: "docker-py"

"Run drone":
  dockerng.running:
    - name: drone
    - restart_policy: always
    - image: hypriot/rpi-drone
    - hostname: drone
    - ports:
      - 80/tcp
    - port_bindings:
      - 8080:80/tcp
    - environment:
      - DRONE_GOGS_URL: http://10.42.0.14:3000
      - DRONE_GOGS_SECRET: 'HJ8ZQ3ldzjmYEVm'
    - binds:
      - /var/run/docker.sock:/var/run/docker.sock
      - /var/lib/drone:/var/lib/drone
    - dns:
      - 8.8.8.8
      - 8.8.4.4
    - require:
      - dockerng: "Download drone/drone"
