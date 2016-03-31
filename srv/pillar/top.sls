base:

  '*':
    - creds.docker
    - settings.settings

  'master':
    - schedule.backup_master

  'db01':
    - creds.postgres
    - schedule.pgdump
    - schedule.backup_db01
