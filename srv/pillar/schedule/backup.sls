schedule:
  backup:
    function: cmd.run
    when: 04:00am
    args:
      - "rsync -av --delete /var/docker/persistent/ root@192.168.2.201:/hdd/backup/kk/"
    kwargs:
      stateful: False
      shell: /bin/sh
