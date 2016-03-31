schedule:
  backup_master:
    function: cmd.run
    when: 04:02am
    args:
      - "rsync -av --delete /var/docker/persistent/ root@192.168.1.9:/hdd/backup/rpi-cluster/master/"
    kwargs:
      stateful: False
      shell: /bin/sh
