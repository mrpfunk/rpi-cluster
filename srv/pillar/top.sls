base:

  '*':
    - creds.docker
#    - settings.settings

  'kk':
    - creds.postgres
    - schedule.regen_certs
    - schedule.updateip
    - schedule.pgdump
    - schedule.backup
