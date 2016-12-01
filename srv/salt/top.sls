base:
  '*':
    - basics
    # - docker

  'kk':
    - bind
    - nginx-vhost
    - postgres
    - gogs
    - registry
    - drone
    - nginx-proxy
    - crossbar
    # - redis

