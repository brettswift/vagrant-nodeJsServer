Exec { path => [ "/bin", "/sbin" , "/usr/bin", "/usr/sbin" ] }

node nodeserver, /us-west-2/{

	$db_user = 'uptimeUser'
	$db_password = 'password'

	class { 'yum':
  	extrarepo => [ 'epel' ],
	}

	include mongodb

	 mongodb::user { $db_user:
      password => $db_password,
    }

	# mongodb::user { $db_user:
 #  	password => $db_password,
	# }

	# $featureBranch = 'versionChecks'
	# $project = 'uptime'
	# $db_name = "uptimeVersionChecks"

	# # TODO move to role/profile
	# class {'mongodb::globals':
	#   manage_package_repo => true,
	# }->
	# class {'mongodb::server': 
	# 	auth => true,
	# }->
	# mongodb::db { "${db_name}":
	#   user          	=> "${db_user}",
	#   password 				=> "${db_password}",
	#   # password_hash => 'a15fbfca5e3a758be80ceaf42458bcd8',
	# }
 	

	# # TODO: when nodesite is pulled into it's own repo, introduce roles/profiles and put node_config
	# # into a file resource (ie production.yaml)
	# class {'nodesite':
	# 	node_version 	=> "v0.10.26",
	# 	git_uri				=> "https://github.com/brettswift/uptime.git",
	# 	git_branch		=> $featureBranch,
	# 	file_to_run 	=> "app.js",
	# 	user 					=> "${project}",
	# 	node_params   => "NODE_CONFIG={\"mongodb\":{\"database\":${db_name}, \"user\":${db_user}, \"password\":${db_password}}}"
	# }

	# Class['mongodb']-> 
	# Class['mongodb::user'] 
	# Class['::mongodb::client']
	# Class['nodesite']

}
