# -*- mode: yaml -*-
base:
  'master*':
    - buildbot_master
    - concourse.master
  'minion[0-1]':
    - buildbot_worker
  'minion2':
    - postgres

