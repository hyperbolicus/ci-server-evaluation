# -*- mode: yaml -*-

{% for i in ["concourse","fly"] %}
download_binary_{{ i }}:
  file.managed:
    - name: /usr/local/bin/{{ i }}
    - source: {{ pillar[i]['url'] }}
    - source_hash: {{ pillar[i]['hash'] }}
    - mode: 755
{% endfor %}

newest_kernel:
  pkg.latest:
    - name: linux-image-amd64
    - refresh: True

add_startscript:
  file.managed:
    - name: /usr/bin/concourse_start.sh
    - source: salt://files/concourse-start.sh
    - template: jinja
    - mode: '0755'

enable_service:
  file.managed:
    - name: /etc/systemd/system/concourse.service
    - source: salt://files/concourse.service
    - mode: '600'
