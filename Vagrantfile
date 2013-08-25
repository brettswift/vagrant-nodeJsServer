# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.define :nodeserver do |nodeserver|

		nodeserver.vm.box = "centos-64-x64-vbox4210-nocm"
		nodeserver.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210-nocm.box"
		nodeserver.vm.hostname = "node-server"

		# host only
		nodeserver.vm.network :private_network, ip: "33.33.33.10"

		#bridged
		# nodeserver.vm.network :public_network

		#plugin is currently broken
		# value = `vagrant snapshot list`
		# puts value

		nodeserver.vm.provision :shell, :path => "bootstrap-vagrant-centos.sh"

		nodeserver.vm.provision :puppet do |puppet|
			puppet.manifests_path = "manifests"
			puppet.module_path    = "modules"
			puppet.manifest_file  = "site.pp"
			puppet.options        = "--verbose --debug"
		end

		nodeserver.vm.provider :virtualbox do |vb|
			vb.customize [
				'modifyvm', :id,
				'--name', 'node_server',
				'--memory', 1024
			]
		end
	end

end






