schedule:
  regen_certs:
    function: cmd.run
    cron: '30 3 4 1-11/2 *'
    args:
      - "docker run --rm -v /var/docker/persistent/nginx-vhost/ssl:/etc/letsencrypt/archive -v /home/manuel/src/rpi-cluster/srv/salt/nginx-vhost/root:/var/letsencrypt bcecchinato/letsencrypt-rpi certonly --webroot -w /var/letsencrypt --agree-tos --email mr.p-funk@gmx.de -d flitzehack.de -d gogs.flitzehack.de -d registry.flitzehack.de -d drone.db01.flitzehack.de -d bla.db01.flitzehack.de -d test.db01.flitzehack.de -d test.flitzehack.de && cp /var/docker/persistent/nginx-vhost/ssl/flitzehack.de/*.pem /var/docker/persistent/nginx-vhost/ssl/certs/ && rm -r /var/docker/persistent/nginx-vhost/ssl/flitzehack.de && docker rm -f nginx-vhost && salt-call state.highstate"
    kwargs:
      stateful: False
      shell: /bin/sh
