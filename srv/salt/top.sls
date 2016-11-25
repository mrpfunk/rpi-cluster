base:
  '*':
    - basics
    - docker

  'kk':
    - postgres
    - gogs

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

