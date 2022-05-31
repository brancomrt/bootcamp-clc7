# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
   config.vm.box = "generic/oracle8"
   config.vm.hostname = "bootcamp-workspace"
   config.vm.provision "shell", path: "requerimentos.sh", run: "once"
      config.vm.provider "virtualbox" do |v|
      v.cpus = 2
      v.memory = 1024
      config.vm.synced_folder "./", "/vagrant"
   end
end
