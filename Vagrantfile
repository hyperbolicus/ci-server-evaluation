# -*- mode: ruby -*-
# vi: set ft=ruby :

IP_BLOCK="172.16.66."

master = {
  :hostname => "master",
  :cpu => 2,
  :cpuexecution => 50,
  :ram => 1024
}
nodes = [
  { :hostname => "minion1", :cpu => 1, :cpuexecution => 50, :ram => 1024 },
  { :hostname => "minion2", :cpu => 1, :cpuexecution => 50, :ram => 1024 },
  { :hostname => "database", :cpu => 1, :cpuexecution => 50, :ram => 1024 }
]

Vagrant.configure("2") do |config|
  # Creating Master
  config.vm.define master[:hostname] do |subconfig|
    subconfig.vm.box = "debian/jessie64"
    subconfig.vm.hostname = master[:hostname]
    subconfig.vm.network "private_network", ip: IP_BLOCK + "10"
    subconfig.vm.network "forwarded_port", guest: 8010, host: 8010
    subconfig.vm.synced_folder "salt/root", "/srv/salt", type: :rsync
    subconfig.vm.synced_folder "salt/pillar", "/srv/pillar", type: :rsync

    subconfig.vm.provision :salt do |salt|
      salt.install_master = true
      salt.master_json_config = '{"interface":"'+ IP_BLOCK + "10" +'","master_id":"master"}'
      salt.master_key = "salt/key/master.pem"
      salt.master_pub = "salt/key/master.pub"
      salt.seed_master = {
        :minion1 => "salt/key/minion1.pub",
        :minion2 => "salt/key/minion2.pub",
        :minion0 => "salt/key/minion0.pub",
        :master => "salt/key/master.pub"
      }
      salt.verbose = true
      salt.minion_id = "master"
      salt.minion_key = "salt/key/master.pem"
      salt.minion_pub= "salt/key/master.pub"
      salt.minion_json_config = '{"master":"'+ IP_BLOCK + "10"+'","id":"master"}'
      salt.python_version = 3
    end
    subconfig.vm.provider :virtualbox do |subprovider|
      subprovider.customize [
        :modifyvm, :id,
        "--cpus", master[:cpu].to_s,
        "--cpuexecutioncap", master[:cpuexecution].to_s,
        "--memory",master[:ram]
      ]
    end
  end
  # Looping over slaves
  nodes.each do |node|
    config.vm.define node[:hostname] do |subconfig|
      idx = nodes.index(node)
      subconfig.vm.box = "debian/jessie64"
      subconfig.vm.hostname = node[:hostname]
      subconfig.vm.network "private_network", ip: IP_BLOCK + (11 + idx).to_s
      subconfig.vm.provision :salt do |salt|
        salt.verbose = true
        salt.python_version = 3
        salt.minion_id = "minion#{idx}"
        salt.minion_key = "salt/key/minion#{idx}.pem"
        salt.minion_pub= "salt/key/minion#{idx}.pub"
        salt.minion_json_config = '{"master":"'+ IP_BLOCK + "10"+'","id":"minion'+idx.to_s+'"}'
      end
    end
  end
end
