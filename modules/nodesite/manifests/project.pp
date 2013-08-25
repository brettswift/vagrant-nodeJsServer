class nodesite::project(
		$gitUri 	 = {},
		$fileToRun = 'app.js',
	){

	$projectDir = "/tmp/gitProjects"

	# TODO: regex to get project name
	$projectNameDirty = regsubst($gitUri, '^(.*[\\\/])', '')
	$projectName = regsubst($projectNameDirty, '.git', '')

	info("##### ---------------->>> project name:    $projectName")

	# class { 'nvm_nodejs':
 #  	user    => 'vagrant',
 #  	version => $nodeVersion,
	# }

	file { "/tmp/gitProjects":
		ensure => directory,
	}

	exec { "cloneProject":
		command => "/usr/bin/git clone --depth 1 $gitUri  &>>$projectName.log",
		cwd			=> "/tmp/gitProjects",
		creates => "/tmp/gitProjects/$projectName.log",
	}

	exec { "pullProject":
		command => "/usr/bin/git pull origin master",
		cwd			=> "/tmp/gitProjects/$projectName",
	}

	exec { "runProject":
		command => "/usr/bin/ls",
		# command => "$nvm_nodejs::NODE_EXEC $fileToRun",
	# 	cwd			=> "$projectDir/$projectName",
	}

	File['/tmp/gitProjects'] -> 
	Exec['cloneProject'] -> 
	Exec['pullProject'] -> 
	Exec['runProject']

}