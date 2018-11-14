# -*- mode: yaml -*-

add_docker_repo:
  pkgrepo.managed:
    - name: "deb [arch=amd64] https://download.docker.com/linux/debian {{ grains['oscodename'] }} stable"
    - enabled: True
    - humanname: Docker PPA
    - keyserver: https://download.docker.com/linux/debian/gpg
    - keyid: 0EBFCD88

add_docker:
  pkg.installed:
    - name: docker-ce
    - version: 18.06.1~ce~3-0~debian 

python-pip:
  pkg.installed

"pip install -U docker":
  cmd.run

run_postgres:
  docker_container.running:
    - name: postgres
    - image: postgres:11.0
    - detach: True
    - environment:
      - POSTGRES_PASSWORD: example
      - POSTGRES_USER: admin
      - POSTGRES_DB: atc
    - port_bindings:
      - 5432:5432

#add_database:
#  postgres_database.present:
#    - name: atc
#    - ownen: admin
#    - db_host: localhost
#    - db_port: 5432
#    - db_user: admin
#    - db_password: example


