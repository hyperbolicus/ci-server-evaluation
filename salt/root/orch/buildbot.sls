# -*- mode: yaml -*-

refresh_pillar:
  salt.function:
    - name: saltutil.refresh_pillar
    - tgt: '*'

refresh_mine:
  salt.function:
    - name: mine.update
    - tgt: '*'
    - require:
      - salt: refresh_pillar

install_buildbot:
  salt.state:
    - tgt: '*'
    - highstate: True
    - require:
      - refresh_mine

start_buildbot_master:
  salt.function:
    - name: cmd.run
    - tgt: 'master*'
    - arg:
      - 'buildbot restart /opt/buildbot'
    - require:
      - install_buildbot

start_buildbot_minion:
  salt.function:
    - name: cmd.run
    - tgt: 'minion[0-1]'
    - arg:
      - 'buildbot-worker restart /opt/buildbot'
    - require:
      - install_buildbot

start_concourse:
  salt.function:
    - name: cmd.run
    - tgt: 'master'
    - arg:
      - 'systemctl enable concourse.service && service concourse start'
    - require:
      - install_buildbot

