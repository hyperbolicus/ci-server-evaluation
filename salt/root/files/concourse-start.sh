{% set addrs = salt['mine.get']('*', 'network.ip_addrs') %}
#!/bin/bash

concourse quickstart \
  --add-local-user test:test \
  --main-team-local-user test \
  --worker-work-dir /opt/concourse \
  --external-url http://{{ addrs['master'][0] }}:8080 \
  --postgres-user admin \
  --postgres-password example \
  --postgres-database atc \
  --postgres-host {{ addrs['minion2'][0] }}
