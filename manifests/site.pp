
# Exec { path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin"}

node node-server {

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


node epdashboard {

	class{ 'mongodb':
		projectName			=> "uptime",
		dbName 					=> "brettUptime",
		dbUser					=> "uptimeUser",
		dbPass					=> "password",
	}

	class {'nodesite':

		nodeVersion => "0.10.10",
		gitUri			=> "https://github.com/brettswift/uptime.git",
		gitBranch		=> "statusCheck",
		fileToRun 	=> "app.js",
		user 				=> "prov",
		npmProxy		=> "wx1.no.cg.lab.nms.mlb.inet:3128",
	}
}

