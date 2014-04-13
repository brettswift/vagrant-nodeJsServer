
# Exec { path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin"}


node nodeserver {

	$project = 'uptime'
	$db_name = 'uptimeStatusUpdate'
	$db_user = 'uptimeUser'
	$db_password = 'password'

	# TODO move to role/profile
	class {'mongodb::globals':
	  manage_package_repo => true,
	}->
	class {'mongodb::server': 
		auth => true,
	}->
	mongodb::db { "${db_name}":
	  user          	=> "${db_user}",
	  password 				=> "${db_password}",
	  # password_hash => 'a15fbfca5e3a758be80ceaf42458bcd8',
	}
 	

	class {'nodesite':
		node_version 	=> "v0.10.26",
		git_uri				=> "https://github.com/brettswift/uptime.git",
		git_branch		=> "versionChecks",
		file_to_run 	=> "app.js",
		user 					=> "${project}",
		node_params   => "NODE_CONFIG='{\"mongodb\":{\"database\":\"uptimeStatusUpdate\", \"user\":\"uptimeUser\", \"password\":\"password\"}}'"
	}

	Class['mongodb::server']-> 
	Class['nodesite']

}

