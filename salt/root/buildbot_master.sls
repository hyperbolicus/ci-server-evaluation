# -*- mode: yml -*-
#Install pip
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
      - "sudo pip3 install -U 'buildbot[bundle]'"
      - "sudo pip3 install -U six"

init_buildbot:
  cmd.run:
    - name: 'buildbot create-master /opt/buildbot'
    - creates:
      - /opt/buildbot
    - require:
      - buildbot

Deploying configuration:
  file.managed:
    - name: /opt/buildbot/master.cfg
    - source: salt://files/master.cfg
    - require:
      - init_buildbot
