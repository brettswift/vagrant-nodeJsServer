class nodejs {
		include nodejs::packages
		include nodejs::nvm

		Class['nodejs::packages']-> 
		Class['nodejs::nvm']
}
