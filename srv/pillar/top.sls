base:

  '*':
    - creds.docker
#    - settings.settings

  'master':
    - schedule.backup_master
    - schedule.regen_certs
    - schedule.updateip

  'db01':
    - creds.postgres
    - schedule.pgdump
    - schedule.backup_db01
