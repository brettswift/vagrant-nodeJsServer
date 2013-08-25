class nodesite::npm {

	file { "/tmp/nvmModule":
		ensure => directory,
	}

	file { "/tmp/nvmModule/install_nvm.sh":
		ensure => file,
		source => "puppet:///modules/nvm/install_nvm.sh",
	}

	exec { "nvm install":
		command => "/bin/bash /tmp/nvmModule/install_nvm.sh &>/tmp/nvmModule/install.log",
		creates	=> "/tmp/nvmModule/install.log",
	}

	File['/tmp/nvmModule'] -> 
	File['/tmp/nvmModule/install_nvm.sh'] -> 
	Exec['nvm install']

}