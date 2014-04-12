
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
		node_version => "0.10.26",
		git_uri			=> "https://github.com/brettswift/uptime.git",
		git_branch		=> "versionChecks",
		file_to_run 	=> "app.js",
		user 				=> $project,
		# npm_proxy		=> "wx1.no.cg.lab.nms.mlb.inet:3128",
	}

	Class['mongodb::server']-> 
	Class['nodesite']

}

