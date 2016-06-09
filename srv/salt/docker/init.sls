"System pip":
  pkg.installed:
    - name: python-pip

"Python pip":
  pip.installed:
    - name: pip
    - upgrade: True
    - onchanges:
      - pkg: 'System pip'

docker-py:
  pip.installed:
    - name: docker-compose
    - require:
      - pip: "Python pip"

dateutil-py:
  pip.installed:
    - name: python-dateutil 
    - require:
      - pip: "Python pip"

croniter-py:
  pip.installed:
    - name: croniter
    - require:
      - pip: "Python pip"

docker:
  service.running
