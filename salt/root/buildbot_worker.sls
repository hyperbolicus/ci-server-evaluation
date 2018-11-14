# -*- mode=yaml -*-

python3-pip:
  pkg:
    - latest
python-pip:
  pkg:
    - latest

buildbot:
  cmd.run:
    - names:
      - "sudo pip3 install -U pip"
      - "sudo pip3 install -U 'buildbot-worker'"
      - "sudo pip3 install -U 'setuptools-trial'"

init_buildbot:
  cmd.run:
    - name: 'buildbot-worker create-worker /opt/buildbot 172.16.66.10 example-worker pass'
    - creates:
      - /opt/buildbot
    - require:
      - buildbot

