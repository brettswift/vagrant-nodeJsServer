#!/bin/bash

############################### 
# Functions 


# usage:  $1 = module
function install_puppet_module_if_required {
 output=`su root -c 'puppet module list'`
 echo $output
 if [[ "$output" == *"$1"* ]]; then
   echo "module $1 already installed"
 else
   echo `su root -c "puppet module install $1"`
   echo "module $1 finished installing"
   echo "** ignore the above message about command not found**"
 fi
}
##############################
	
echo "running bootstrap.  Installing nvm . . . "
 

echo "$(install_puppet_module_if_required proletaryo-nvm_nodejs)"
echo "$(install_puppet_module_if_required puppetlabs-stdlib)"



echo "######## bootstrap completed #########"



