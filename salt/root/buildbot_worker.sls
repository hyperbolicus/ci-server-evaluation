# -*- mode=yaml -*-
{% set addrs = salt['mine.get']('master','network.ip_addrs') %}
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
    - name: 'buildbot-worker create-worker /opt/buildbot {{ addrs['master'][0] }} example-worker pass'
    - creates:
      - /opt/buildbot
    - require:
      - buildbot

