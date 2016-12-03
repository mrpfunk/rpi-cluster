base:
  '*':
    - basics
    # - docker

  'kk':
    - bind
    - nginx-proxy
    - nginx-vhost
    - postgres
    - gogs
    - registry
    - drone
    - crossbar

