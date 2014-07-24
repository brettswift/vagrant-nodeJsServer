
# Exec { path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin"}
Exec { path => [ "/bin", "/sbin" , "/usr/bin", "/usr/sbin" ] }

node nodeserver, /us-west-2/{
	$featureBranch = 'versionChecks'
	$project = 'uptime'
	$db_name = "uptimeVersionChecks"
	$db_user = 'uptimeUser'
	$db_password = 'password'

	# TODO move to role/profile
	class {'mongodb::globals':
	  manage_package_repo 		=> true,
	  server_package_name			=> "mongodb-org-server",
	}->
	class {'mongodb::server':
		auth => true,
	}->
	mongodb::db { "${db_name}":
	  user          	=> "${db_user}",
	  password 				=> "${db_password}",
	  # password_hash => 'a15fbfca5e3a758be80ceaf42458bcd8',
	}


	# TODO: when nodesite is pulled into it's own repo, introduce roles/profiles and put node_config
	# into a file resource (ie production.yaml)
	class {'nodesite':
		node_version 	=> "v0.10.26",
		git_uri				=> "https://github.com/brettswift/uptime.git",
		git_branch		=> $featureBranch,
		file_to_run 	=> "app.js",
		user 					=> "${project}",
		node_params   => "NODE_CONFIG={\"mongodb\":{\"database\":${db_name}, \"user\":${db_user}, \"password\":${db_password}}}"
	}

	Class['mongodb::server']->
	Class['nodesite']

}

