docker-py:
  pip.installed:
    - name: docker-compose
    - require:
      - pip: "Python pip"

docker:
  service.running
