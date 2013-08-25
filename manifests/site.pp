
# Exec { path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin"}

node node-server {

	require mongodb 
	class {'nvm':} -> 
	class {'nodesite':

		nodeVersion => "0.10.10",
		gitUri			=> "https://github.com/brettswift/uptime.git",
		fileToRun 	=> "app.js",
	}
}

