base:
  '*':
    - basics
    - docker

  'kk':
    - nginx-vhost
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

