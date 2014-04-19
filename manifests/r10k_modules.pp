exec {'r10k' :
	command 		=> 'r10k -v debug puppetfile install > r10k.log 2>&1',
	path	 			=> ['/bin','/usr/bin','/opt/puppet/bin'],
}

package { "r10k":
	ensure 		=> latest,
	provider 	=> 'gem',
}

Package['r10k']->
Exec['r10k']