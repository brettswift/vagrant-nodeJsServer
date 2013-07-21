#!/bin/bash

############################### 
# Functions 

# return 1 if global command line program installed, else 0
# example
# echo "node: $(program_is_installed node)"
function program_is_installed {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  type $1 >/dev/null 2>&1 || { local return_=0; }
  # return value
  echo "$return_"
}

##############################

install_count=$((
			$(program_is_installed git) + 
			$(program_is_installed puppet)
			));

if [ "$install_count" != "2" ]; then
	echo "running bootstrap.  Installing git, puppet . . . "
	su -c 'yum update -y' 
	 
	su -c 'yum install git -y'
	# # puppet repo
	su -c  'rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm'

	# # puppet
	su -c 'yum install puppet -y'

	#TODO: this needs to move into puppet
	su -c 'puppet module install proletaryo/nvm_nodejs'
else
	echo "bootstrap previously completed.  Git, puppet already installed."
fi


