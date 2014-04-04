
# Exec { path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin"}


node nodeserver {

	$project = 'uptime'

	class {'mongodb::globals':
	  manage_package_repo => true,
	}->
	class {'mongodb::server': 
		auth => true,
	}->
	mongodb::db { 'uptimeStatusUpdate':
	  user          	=> 'uptimeUser',
	  password 				=> 'password',
	  # password_hash => 'a15fbfca5e3a758be80ceaf42458bcd8',
	}
 	

	class {'nodesite':
		nodeVersion => "0.10.10",
		gitUri			=> "https://github.com/brettswift/uptime.git",
		gitBranch		=> "statusCheck",
		fileToRun 	=> "app.js",
		user 				=> $project,
		# npmProxy		=> "wx1.no.cg.lab.nms.mlb.inet:3128",
	}

	Class['mongodb::server']-> 
	Class['nodesite']

}

