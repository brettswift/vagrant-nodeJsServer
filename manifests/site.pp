
# Exec { path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin"}

node old_server {

	class{ 'mongodb':
		projectName			=> "uptime",
		dbName 					=> "brettUptime",
		dbUser					=> "uptimeUser",
		dbPass					=> "password",
	}
  # class {'nvm::install':} -> 
	class {'nodesite':

		nodeVersion => "0.10.10",
		gitUri			=> "https://github.com/brettswift/uptime.git",
		gitBranch		=> "statusCheck",
		fileToRun 	=> "app.js",
		user 				=> "vagrant",
	}
}


node nodeserver {


	class {'mongodb::globals':
	  manage_package_repo => true,
	}->
	class {'mongodb::server': 
		auth => true,
	}->
	mongodb::db { 'uptime':
	  user          	=> 'uptimeUser',
	  password 				=> 'password',
	  # password_hash => 'a15fbfca5e3a758be80ceaf42458bcd8',
	}
 	

	class {'nodesite':

		nodeVersion => "0.10.10",
		gitUri			=> "https://github.com/brettswift/uptime.git",
		gitBranch		=> "statusCheck",
		fileToRun 	=> "app.js",
		user 				=> "prov",
		# npmProxy		=> "wx1.no.cg.lab.nms.mlb.inet:3128",
	}

	Class['mongodb::server']-> 
	Class['nodesite']->
	info("node exe: $nvm_nodejs::NODE_EXEC")
	info("npm exec: $nvm_nodejs::NPM_EXEC")
	info("node path: $nvm_nodejs::NODE_PATH")




	
}

