schedule:
  regen_certs:
    function: cmd.run
    cron: '30 3 4 1-11/2 *'
    args:
      - "docker run --rm \
            -v /var/docker/persistent/nginx-vhost/ssl:/etc/letsencrypt/archive \
            -v /var/docker/persistent/nginx-vhost/root:/var/www \
            -v /tmp:/var/log/letsencrypt \
            lojzik/letsencrypt \
                certonly --webroot \
                -a webroot \
                --webroot-path /var/www \
                --agree-tos \
                --email mr.p-funk@gmx.de \
                -d flitzehack.de \
                -d gogs.flitzehack.de \
                -d registry.flitzehack.de \
                -d drone.db01.flitzehack.de \
                -d bla.db01.flitzehack.de \
                -d test.db01.flitzehack.de \
                -d test.flitzehack.de \
         && cp /var/docker/persistent/nginx-vhost/ssl/flitzehack.de/*.pem /var/docker/persistent/nginx-vhost/ssl/certs/ \
         && rm -r /var/docker/persistent/nginx-vhost/ssl/flitzehack.de \
         && docker rm -f nginx-vhost \
         && salt-call state.apply nginx-vhost"
    kwargs:
      stateful: False
      shell: /bin/sh
