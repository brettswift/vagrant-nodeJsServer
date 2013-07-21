class nodejs::packages{


	package{"make":
		ensure => latest,
	}

	package{"git":
		ensure => latest,
	}

	package{"curl":
		ensure => latest,
	}

}