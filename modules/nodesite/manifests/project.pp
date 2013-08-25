class nodesite::project(
		$gitUri 	 		= {},
		$fileToRun 		= 'app.js',
		$nodeVersion 	= {},
	){

	$projectDir = "/tmp/gitProjects"

	# TODO: regex to get project name
	$projectNameDirty = regsubst($gitUri, '^(.*[\\\/])', '')
	$projectName = regsubst($projectNameDirty, '.git', '')

	
	class { 'nvm_nodejs':
  	user    => 'vagrant',
  	version => $nodeVersion,
	}

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
		command => "/bin/ls",
		# command => "$nvm_nodejs::NODE_EXEC $fileToRun",
		# cwd			=> "$projectDir/$projectName",
	}

	Class['nvm_nodejs'] -> 
	File['/tmp/gitProjects'] -> 
	Exec['cloneProject'] -> 
	Exec['pullProject'] -> 
	Exec['runProject']
	
	info("##### ---------------->>> git URI:    $gitUri")
	info("##### ---------------->>> project name:    $projectName")
	info("node exe: $nvm_nodejs::NODE_EXEC")

}