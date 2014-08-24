class profiles::uptime_nodesite 
{
# (  re-enable class params when hiera comes in. 
# 		$git_uri 					= undef,
# 		$git_branch				= master,
# 		$project_name 		= 'nodesite',
# 		$db_name					= undef,
# 		$db_user					= undef,
# 		$db_password			= undef,
# 	)

	#**** data until we get hiera enabled
  # $git_branch				= 'bugfix/config_file'
  $db_name               = "uptimeVersionChecks"
  $db_user               = 'uptimeUser'
  $db_password           = 'password'
	$git_uri               =  "https://github.com/brettswift/uptime.git"
	# $git_uri             =  "https://github.com/fzaninotto/uptime.git"
	$project_name          = "uptime"
	$db_connection_string  = "mongodb://localhost/uptimeVersionChecks"
	#****

	class {'profiles::mongo_database':
	  db_name => $db_name,
	  db_user => $db_user,
	  db_password => $db_password,
	}


  $uptime_config = {
    "mongodb/database" => { value => $db_name },
    "mongodb/user" => { value => $db_user },
    "mongodb/password" => { value => $db_password },
    "mongodb/connectionString" => { value => $db_connection_string}
  }

	# TODO: put node_config into a file resource (ie production.yaml)
	# $node_params="NODE_CONFIG={\"mongodb\":{\"database\":${db_name}, \"user\":${db_user}, \"password\":${db_password}}}"
	class {'nodesite':
		node_version 	=> "v0.10.26",
		git_uri				=> $git_uri,
		git_branch		=> $git_branch,
		file_to_run 	=> "app.js",
		user 					=> "${project_name}",
		yaml_file     => "config/default.yaml",  #relative path from git project root.
    yaml_entries  => $uptime_config,
	}

	Class['profiles::mongo_database']->
	Class['nodesite']
	
}