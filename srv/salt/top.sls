base:
  '*':
    - basics
    # - docker

  'kk':
    - bind
    - redis
    - nginx-proxy
    - nginx-vhost
    - postgres
    - gogs
    - registry
    - drone
    - crossbar

