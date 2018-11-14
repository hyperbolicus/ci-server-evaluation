# -*- mode: yaml -*-

install_buildbot:
  salt.state:
    - tgt: '*'
    - highstate: True

start_buildbot_master:
  salt.function:
    - name: cmd.run
    - tgt: 'master*'
    - arg:
      - 'buildbot restart /opt/buildbot'

start_buildbot_minion:
  salt.function:
    - name: cmd.run
    - tgt: 'minion*'
    - arg:
      - 'buildbot-worker restart /opt/buildbot'
