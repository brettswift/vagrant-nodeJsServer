
# Exec { path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin"}

node node-server {
	include nodejs
	
	# https://forge.puppetlabs.com/proletaryo/nvm_nodejs
	class { 'nvm_nodejs':
  	user    => 'vagrant',
  	version => '0.8.23',
	}
# $nvm_nodejs::NODE_PATH : path to the bin directory
# $nvm_nodejs::NODE_EXEC : full executable path of node engine
# $nvm_nodejs::NPM_EXEC : full executable path of npm

	info("##### node path: $nvm_nodejs::NODE_PATH")
	# TODO: add node path to PATH variable, when running the node server process for a particular app. 

}


