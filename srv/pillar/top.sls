base:

  '*':
    - creds.docker
    - settings.settings

  'db01':
    - creds.postgres
    - schedule.pgdump
