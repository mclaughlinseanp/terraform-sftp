# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  
  config.vm.define :"control-machine", primary: true do |acs|
    acs.vm.box =  "bento/ubuntu-16.04"
    acs.vm.network "private_network", ip: "192.168.88.101"
	acs.vm.hostname = "control-machine"
	acs.vm.provider :virtualbox do |vb|
		vb.customize ['modifyvm', :id,'--memory', '1536']
	end
	acs.vm.provision "shell", path: "control-machine-init.sh"
  end
  
end