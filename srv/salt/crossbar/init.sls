"Download crossbar":
  dockerng.image_present:
    - name: registry.flitzehack.de/crossbar

"Download redis":
  dockerng.image_present:
    - name: 'redis'


{% for usr in pillar.get('clients', []) %}

"redis-{{ usr }}-exists":
  file.directory:
    - name: /var/docker/persistent/redis/{{ usr }}
    - dir_mode: 755
    - makedirs: True

"redis-{{ usr }}-run":
  dockerng.running:
    - name: redis-{{ usr }}
    - restart_policy: always
    - image: redis
    - ports:
      - 6379/tcp
    - binds:
      - /var/docker/persistent/redis-{{ usr }}:/data
    - dns:
      - 192.168.2.254
    - require:
      - file: redis-{{ usr }}-exists
      - dockerng: "Download redis"

"crossbar-{{ usr }}-run":
  dockerng.running:
    - name: cb-{{ usr }}
    # - restart_policy: always
    - detach: True
    - image: registry.flitzehack.de/crossbar
    - ports:
      - 80/tcp
    - environment:
      # - VIRTUAL_HOST: "test1.cb.{{ salt['pillar.get']('domain:name') }}"
      - VIRTUAL_HOST: "{{ usr }}.cb.flitzehack.de"
    - binds:
      - /home/mnowak/src/crossbar/node:/node/.crossbar
      - /home/mnowak/src/ap:/node/web
      - /home/mnowak/src/wamplets3:/node/wamplets
    - links:
      - redis-{{ usr }}:redis
    - dns:
      - 192.168.2.254
    - require:
      - dockerng: "Download crossbar"
      - dockerng: "redis-{{ usr }}-run"

{% endfor %}
