class mongodb::config(
		$projectName	= {},
		$dbName 	 		= {},
		$dbUser				= {},
		$dbPass 			= {},
	){
	#TODO: move vars above to params 
	
	file { ["/tmp/mongodb/",
					"/tmp/mongodb/$projectName"]:
		ensure => directory,
	}

	file { "initMongo.js":
		path			=> "/tmp/mongodb/$projectName/initMongo.js",
		content 	=> template("mongodb/initMongo.js.erb"),
	}

	exec { "initializeDatabase":
		command => "/usr/bin/mongo initMongo.js",
		cwd			=> "/tmp/mongodb/$projectName/",
		user 		=> "root",
	}

	File["initMongo.js"] -> 
	Exec["initializeDatabase"]


}