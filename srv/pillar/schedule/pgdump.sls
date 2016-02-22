schedule:
  pgdump:
    function: cmd.run
    when: 03:30am
    args:
      - "docker run --link postgres:postgres -v /root:/root --rm ldouchy/rpi-postgres sh -c 'pg_dumpall -h postgres -U postgres > /root/pg.dump'"
    kwargs:
      stateful: False
      shell: /bin/sh
