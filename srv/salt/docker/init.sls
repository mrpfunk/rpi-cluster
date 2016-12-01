docker-py-bkg:
  pip.installed:
    - name: docker-compose
    - require:
      - pip: "Python pip"

docker-python-apt:
  pkg.installed:
    - name: python-apt

docker-dependencies:
   pkg.installed:
    - pkgs:
      - iptables
      - ca-certificates
      - lxc
      - python-pip

docker-py:
  pip.installed:
    - require:
      - pkg: docker-dependencies

docker_repo:
    pkgrepo.managed:
      - name: 'deb https://apt.dockerproject.org/repo debian-stretch main'
      - file: '/etc/apt/sources.list.d/docker.list'
      - key_url: salt://docker/docker.pgp
      - require_in:
          - pkg: lxc-docker
      - require:
        - pkg: docker-python-apt

lxc-docker:
  pkg.latest:
    - require:
      - pkg: docker-dependencies

docker:
  service.running
