Vagrant Nodejs Server
=====================

This project bootstraps a Vagrant box with Puppet and Puppet-librarian.

It wraps the brettswift/nodesite puppet module which deploys and configures a nodejs application on a specified version of nodejs.  

The nodejs application is configured simply with: 

* the git URI
* branch/tag (default: master)
* file to start your web app (default app.js)


Run: `vagrant up` and you will have a running nodejs application in under 4 minutes mapped to `http://localhost:8082`. 

By default, this is conifigured to run my feature branch of [Uptime](http://redotheweb.com/uptime) hosted on github https://github.com/brettswift/uptime



Project Structure
-----------------
* `manifests/site.pp` node classification
* `site` local module code
* `modules` installed by librarian-puppet
* `shell` bootstrap provisioners. 
		* capable of running a base vagrant box without puppet

