base:
  '*':
    - basics
    - docker

  'master':
    - nginx-vhost
    # - nginx-proxy

  'db01':
    - nginx-proxy
    - web
    - postgres
    - gogs
    - drone
    - registry
    # - crossbar

