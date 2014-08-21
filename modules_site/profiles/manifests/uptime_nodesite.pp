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
  $db_name = "uptimeVersionChecks"
  $db_user = 'uptimeUser'
  $db_password = 'password'
	$git_uri =  "https://github.com/brettswift/uptime.git"
	$project_name = "uptime"
	#****

	$node_params="NODE_CONFIG={\"mongodb\":{\"database\":${db_name}, \"user\":${db_user}, \"password\":${db_password}}}"

	class {'profiles::mongodb':
	  db_name => $db_name,
	  db_user => $db_user,
	  db_password => $db_password,
	}
	# TODO: when nodesite is pulled into it's own repo, introduce roles/profiles and put node_config
	# into a file resource (ie production.yaml)
	class {'nodesite':
		node_version 	=> "v0.10.26",
		git_uri				=> $git_uri,
		git_branch		=> $featureBranch,
		file_to_run 	=> "app.js",
		user 					=> "${project_name}",
		node_params   => $node_params
	}

	Class['profiles::mongodb']->
	Class['nodesite']
	
}