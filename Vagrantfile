# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.4.0"

# unless Vagrant.has_plugin?("vagrant-librarian-puppet") then
# 	raise "please run: `vagrant plugin install vagrant-librarian-puppet` as this plugin is required."
# end

Vagrant.configure("2") do |config|
	config.vm.define :nodeserver do |nodeserver|
		hostname = "nodeserver"
		nodeserver.vm.box = "centos-65-x64-virtualbox-puppet"
		# nodeserver.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"
		nodeserver.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"
		nodeserver.vm.hostname = hostname

		# host only
		nodeserver.vm.network :private_network, ip: "33.33.33.10"
    nodeserver.vm.network :forwarded_port, guest: 8082, host: 8082

		nodeserver.vm.provision :shell, :path => "./shell/bootstrap-vagrant-centos.sh"
		# nodeserver.vm.provision :shell, :path => "./shell/bootstrap_r10k.sh"
		# nodeserver.vm.provision :shell, :path => "./shell/bootstrap_librarian.sh"
		# nodeserver.vm.provision :shell, :path => "./shell/run_puppet.sh"
	
		#BROKEN - with r10k this must run from the shell script.. retest to get it working. 
		nodeserver.vm.provision :puppet do |puppet|
			puppet.manifests_path 		= "manifests"
			puppet.manifest_file  		= "r10k_modules.pp"
			# puppet.temp_dir					= "/tmp/puppet"
			puppet.working_directory	= "/vagrant"
			puppet.options 						= "--verbose"
			# puppet.module_path 			= ['modules']
			# puppet.options        	= "--verbose --debug  "#--graph --graphdir /vagrant/graphs"
		end

		nodeserver.vm.provision :puppet do |puppet|
			puppet.manifests_path = "manifests"
			puppet.manifest_file  = "site.pp"
			puppet.module_path 		= 'modules'
			# puppet.temp_dir				= "/tmp/puppet"
			puppet.working_directory			= "/vagrant"
			# puppet.options        = "--verbose --debug  "#--graph --graphdir /vagrant/graphs"
		end

		nodeserver.vm.provider :virtualbox do |vb|
			vb.customize [
				'modifyvm', :id,
				'--name', hostname,
				'--memory', 1024
			]
		end
	end

	config.vm.define :amazon do |nodeserver|
		nodeserver.vm.box = "dummy"

		nodeserver.vm.provision :shell, :path => "./shell/bootstrap-vagrant-centos.sh"
		# nodeserver.vm.provision :shell, :path => "./shell/bootstrap_r10k.sh"
		# nodeserver.vm.provision :shell, :path => "./shell/run_puppet.sh"
	

	# puppet apply -vv --modulepath=$PUPPET_DIR/modules:$PUPPET_DIR/site $PUPPET_DIR/manifests/site.pp

		#BROKEN - with r10k this must run from the shell script.. retest to get it working. 
		nodeserver.vm.provision :puppet do |puppet|
			puppet.manifests_path 		= ['vm','/vagrant/manifests']
			puppet.manifest_file  		= "r10k_modules.pp"
			puppet.working_directory	= "/vagrant"
			puppet.options        		= "--modulepath=/vagrant/modules --verbose"#--graph --graphdir /vagrant/graphs"
		end

		nodeserver.vm.provision :puppet do |puppet|
			puppet.manifests_path 		    = ['vm','/vagrant/manifests']
			puppet.manifest_file          = "site.pp"
			puppet.working_directory			= "/vagrant"
			puppet.options                = "--modulepath=/vagrant/modules --verbose"#--graph --graphdir /vagrant/graphs"
		end

		nodeserver.vm.provider :aws do |aws, override|
		  config.ssh.pty                = true
			aws.keypair_name              = "vagrant"
			aws.access_key_id             = "#{ENV['AWS_ACCESS_KEY']}"  
			aws.secret_access_key         = "#{ENV['AWS_SECRET_KEY']}"  
			# aws.ami                     = "ami-043a5034" # amazon linux 64bit. puppet 2.7 :( 
			aws.ami                       = "ami-b158c981" #centos 64 bit minimal:  http://goo.gl/tqeOty
			aws.region                    = "us-west-2"
			aws.instance_type             = "t1.micro"
			aws.security_groups           = ["default"]
			override.ssh.username         = 'root'
			override.ssh.private_key_path = "~/.ssh/aws/vagrant.pem"
			aws.tags                      = {
																				'Name' => 'Uptime'
																			}

		end

		# nodeserver.vm.provider :virtualbox do |vb|
		# 	vb.customize [
		# 		'modifyvm', :id,
		# 		'--name', hostname,
		# 		'--memory', 1024
		# 	]
		# end
	end

end