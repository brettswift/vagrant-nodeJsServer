Exec { path => [ "/bin", "/sbin" , "/usr/bin", "/usr/sbin" ] }

node nodeserver, /us-west-2/{

	include roles::uptime

}

