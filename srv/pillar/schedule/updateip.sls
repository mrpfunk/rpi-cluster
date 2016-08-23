schedule:
  updateip:
    function: cmd.run
    minutes: 15
    splay: 30
    args:
      - "/usr/local/bin/updateip.py"
    kwargs:
      stateful: False
      shell: /bin/sh
