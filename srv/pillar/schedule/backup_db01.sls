schedule:
  backup_db01:
    function: cmd.run
    when: 04:00am
    args:
      - "rsync -av --delete /var/docker/persistent/ root@192.168.1.9:/hdd/backup/rpi-cluster/db01/"
    kwargs:
      stateful: False
      shell: /bin/sh
