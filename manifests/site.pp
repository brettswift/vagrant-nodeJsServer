
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
	}
}

