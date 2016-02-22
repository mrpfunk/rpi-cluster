base:

  '*':
    - creds.docker

  'db01':
    - creds.postgres
    - schedule.pgdump
