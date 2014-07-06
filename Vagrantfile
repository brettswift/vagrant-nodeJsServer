# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.5.0"

# unless Vagrant.has_plugin?("vagrant-librarian-puppet") then
# 	raise "please run: `vagrant plugin install vagrant-librarian-puppet` as this plugin is required."
# end

Vagrant.configure("2") do |config|
	config.vm.define :nodeserver do |nodeserver|

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


		################################
		########  Providers ############
		nodeserver.vm.provider :virtualbox do |vb|

			
			nodeserver.vm.network :private_network, ip: "33.33.33.10"
	    nodeserver.vm.network :forwarded_port, guest: 8082, host: 8082

			vb.customize [
				'modifyvm', :id,
				'--name', hostname,
				'--memory', 1024
			]
		end


		nodeserver.vm.provider :aws do |aws, override|

			override.vm.box 			= "aws" #used for cloud provisioners
			override.vm.box_url 	= "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"

		  config.ssh.pty                = true
			aws.keypair_name              = "vagrant"
			aws.access_key_id             = "#{ENV['AWS_ACCESS_KEY_ID']}"  
			aws.secret_access_key         = "#{ENV['AWS_SECRET_ACCESS_KEY']}"  
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
		config.vm.provider :rackspace do |rs, override|

			override.vm.box 			        = "rackspace"
			override.vm.box_url 	        = "https://github.com/mitchellh/vagrant-rackspace/raw/master/dummy.box"
	    rs.username                   = "brettswift"
	    rs.api_key                    = "70cadbcdeff50da9b43814bd8812faba"
	    rs.flavor                     = /512MB Standard Instance/
	    rs.image                      = /CentOS 6.5/
			override.ssh.private_key_path = "~/.ssh/aws/vagrant.pem"
	    # rs.metadata = {"key" => "value"}       # optional
  	end

		nodeserver.vm.provider :azure do |azure, override|
				#to generate a cert: 
				# openssl req -x509 -nodes -days 3650  -newkey rsa:1024 -keyout cert.pem -out cert.pem
				# openssl pkcs12 -export -out cert.pfx -in cert.pem -name "Bretts Azure Cert"
				# openssl x509 -inform pem -in cert.pem -outform der -out cert.cer

				# openssl req -out CSR.csr -key ~/.ssh/azure/new/id_rsa -new
				# openssl x509 -req -days 3650 -in ./CSR.csr -signkey ~/.ssh/azure/new/id_rsa -out vagrant.crt
				
				# https://devcenter.heroku.com/articles/ssl-certificate-self

				override.vm.box 		     = "azure" #used for cloud provisioners
				override.vm.box_url 	   = "https://github.com/MSOpenTech/vagrant-azure/blob/master/dummy.box"
		    
		    azure.vm_image						 = "CentOS6-5-Minimal"

        # azure.mgmt_certificate     = "#{ENV['HOME']}/.ssh/azure/new/vagrant.crt"
        azure.mgmt_certificate     = "#{ENV['HOME']}/.ssh/azure/new2/cert.pem"
        azure.mgmt_endpoint        = 'https://management.core.windows.net'
        azure.subscription_id      = "#{ENV['AZURE_SUBSCRIPTION_ID']}"
        # azure.storage_acct_name 	 = 'brettswiftstorage' # optional. A new one will be generated if not provided.

        # azure.vm_user = 'PROVIDE A USERNAME' # defaults to 'vagrant' if not provided
        azure.vm_password          = "#{ENV['AZURE_VM_PASSWORD']}" # min 8 characters. should contain a lower case letter, an uppercase letter, a number and a special character

        azure.vm_name              = 'NodesiteServer' # max 15 characters. contains letters, number and hyphens. can start with letters and can end with letters and numbers
        azure.cloud_service_name 	 = 'brettswifttesting' # same as vm_name. leave blank to auto-generate
        # azure.deployment_name = 'PROVIDE A NAME FOR YOUR DEPLOYMENT' # defaults to cloud_service_name
        azure.vm_location 				 = 'West US' # e.g., West US
        azure.ssh_private_key_file = "#{ENV['HOME']}/.ssh/azure/new/id_rsa"
        azure.ssh_certificate_file = "#{ENV['HOME']}/.ssh/azure/new/id_rsa.pub"

        # Provide the following values if creating a *Nix VM
        azure.ssh_port             = '22' #A VALID PUBLIC PORT


        azure.tcp_endpoints        = '8082:443:22:80' # opens the Remote Desktop internal port that listens on public port 53389. Without this, you cannot RDP to a Windows VM.
        # azure.tcp_endpoints = '3389:53389' # opens the Remote Desktop internal port that listens on public port 53389. Without this, you cannot RDP to a Windows VM.
    end

    config.vm.provider :digital_ocean do |provider, override|
	    override.ssh.private_key_path = '~/.ssh/id_rsa'
	    override.vm.box               = 'digital_ocean'
	    override.vm.box_url           = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"

	    provider.client_id            = "#{ENV['DIGITAL_OCEAN_CLIENT_ID']}"
	    provider.api_key              = "#{ENV['DIGITAL_OCEAN_API_KEY']}"
	    # provider.image								= "CentOS 6.5 x64"

	  end

	  # think these are for aws and azure only? 
    config.ssh.username = 'vagrant' # the one used to create the VM
    config.ssh.password = 'Pa55w0rd!' # the one used to create the VM

	end
end