# -*- mode: yaml -*-

{% for i in ["concourse","fly"] %}
download_binary_{{ i }}:
  file.managed:
    - name: /usr/local/bin/{{ i }}
    - source: {{ pillar[i]['url'] }}
    - source_hash: {{ pillar[i]['hash'] }}
    - mode: 755
{% endfor %}
