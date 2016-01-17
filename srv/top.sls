base:
  '*':
    - docker

  'master':
    - nginx-vhost
    # - nginx-proxy

  'db01':
    # - nginx-proxy
    # - postgres
    - gogs

