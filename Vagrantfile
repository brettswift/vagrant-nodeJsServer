# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.5.0"

# unless Vagrant.has_plugin?("vagrant-librarian-puppet") then
# 	raise "please run: `vagrant plugin install vagrant-librarian-puppet` as this plugin is required."
# end

Vagrant.configure("2") do |config|
	config.vm.define :web_server do |nodeserver|

		#virtualbox (cloud providers redefine this)
		nodeserver.vm.box      = "centos-65-x64-virtualbox-puppet"
		nodeserver.vm.box_url  = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"

		hostname               = "nodeserver"
		nodeserver.vm.hostname = hostname

		nodeserver.vm.provision :shell, :path => "./shell/bootstrap-vagrant-centos.sh"

		nodeserver.vm.provision :puppet do |puppet|
			puppet.manifests_path 		= "manifests"
			puppet.manifest_file  		= "r10k_modules.pp"
			puppet.working_directory	= "/vagrant"
			puppet.options 						= "--verbose"
		end

		nodeserver.vm.provision :puppet do |puppet|
			puppet.manifests_path         = "manifests"
			puppet.manifest_file          = "site.pp"
			puppet.module_path 		        = 'modules'
			puppet.working_directory			= "/vagrant"
			puppet.options        				= "--verbose"#--graph --graphdir /vagrant/graphs"
		end

		nodeserver.vm.network :private_network, ip: "33.33.33.10"
    nodeserver.vm.network :forwarded_port, guest: 8082, host: 8082

		################################
		########  Providers ############
		nodeserver.vm.provider :virtualbox do |vb, override|

			vb.customize [
				'modifyvm', :id,
				'--name', hostname,
				'--memory', 1024
			]
		end


		# nodeserver.vm.provider :aws do |aws, override|

		# 	override.vm.box 			= "aws" #used for cloud provisioners
		# 	override.vm.box_url 	= "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"

		#   config.ssh.pty                = true
		# 	aws.keypair_name              = "vagrant"
		# 	aws.access_key_id             = "#{ENV['AWS_ACCESS_KEY_ID']}"
		# 	aws.secret_access_key         = "#{ENV['AWS_SECRET_ACCESS_KEY']}"
		# 	# aws.ami                     = "ami-043a5034" # amazon linux 64bit. puppet 2.7 :(
		# 	aws.ami                       = "ami-b158c981" #centos 64 bit minimal:  http://goo.gl/tqeOty
		# 	aws.region                    = "us-west-2"
		# 	aws.instance_type             = "t1.micro"
		# 	aws.security_groups           = ["default"]
		# 	override.ssh.username         = 'root'
		# 	override.ssh.private_key_path = "~/.ssh/aws/vagrant.pem"
		# 	aws.tags                      = {
		# 																		'Name' => 'Uptime'
		# 																	}

		#   # think these are for aws only?
	 #    override.ssh.username = 'vagrant' # the one used to create the VM
	 #    override.ssh.password = 'Pa55w0rd!' # the one used to create the VM
		# end

  #   config.vm.provider :digital_ocean do |provider, override|
	 #    override.ssh.private_key_path = '~/.ssh/id_rsa'
	 #    override.vm.box               = 'digital_ocean'
	 #    override.vm.box_url           = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"

	 #    provider.client_id            = "#{ENV['DIGITAL_OCEAN_CLIENT_ID']}"
	 #    provider.api_key              = "#{ENV['DIGITAL_OCEAN_API_KEY']}"
	 #    provider.image								= 'CentOS 6.5 x64'

	 #  end


	end
end