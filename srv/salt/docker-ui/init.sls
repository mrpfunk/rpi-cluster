"Download hypriot/rpi-dockerui":
  dockerng.image_present:
    - name: 'hypriot/rpi-dockerui'

"Run docker-ui":
  dockerng.running:
    - name: docker-ui 
    - privileged: True
    - detach: True
    - restart_policy: always
    - image: hypriot/rpi-dockerui
    - ports:
      - 9000/tcp
    - binds:
      - /var/run/docker.sock:/var/run/docker.sock
    - port_bindings:
      - 9000:9000/tcp
    - dns:
      - 192.168.2.254
      - 8.8.4.4
    - require:
      - dockerng: "Download hypriot/rpi-dockerui"

