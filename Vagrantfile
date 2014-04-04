# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.4.0"

# unless Vagrant.has_plugin?("vagrant-librarian-puppet") then
# 	raise "please run: `vagrant plugin install vagrant-librarian-puppet` as this plugin is required."
# end

Vagrant.configure("2") do |config|
	config.vm.define :nodeserver do |nodeserver|
		hostname = "nodeserver"
		nodeserver.vm.box = "centos-64-x64-vbox4210-nocm"
		nodeserver.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"
		nodeserver.vm.hostname = hostname

		# host only
		nodeserver.vm.network :private_network, ip: "33.33.33.10"
    nodeserver.vm.network :forwarded_port, guest: 8082, host: 8082

		nodeserver.vm.provision :shell, :path => "bootstrap-vagrant-centos.sh"
		nodeserver.vm.provision :shell, :path => "bootstrap_librarian.sh"
		# nodeserver.vm.provision :shell, :inline => "rm /vagrant/graphs/*.dot"
	
		#BROKEN - with librarian this must run from the shell script
		# nodeserver.vm.provision :puppet do |puppet|
		# 	puppet.manifests_path = "manifests"
		# 	puppet.manifest_file  = "site.pp"
		# 	puppet.module_path 		= ['site/','modules/']
		# 	puppet.options        = "--verbose --debug  "#--graph --graphdir /vagrant/graphs"
		# end

		nodeserver.vm.provider :virtualbox do |vb|
			vb.customize [
				'modifyvm', :id,
				'--name', hostname,
				'--memory', 512
			]
		end
	end
end