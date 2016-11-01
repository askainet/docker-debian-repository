Debian-repository for Docker
============================

A local repository for publishing deb files for use with apt.

This docker box provides an apt repository based on the tool reprepro.
The repository is served by an nginx server.
Supports signed packages.


Usage
-----

### Running the box

Run with 22 and 80 ports opened.
Share a directory containing your public SSH keys for uploading packages.
Share a directory containing your GPG key pair for signing packages.
Share a directory for storing your packages repository.

	docker run -d \
	  -v /path/to/keys:/docker/keys \
	  -v /path/to/gpg:/docker/gpg \
	  -v /path/to/repository:/repository \
	  -p 49160:22 -p 49161:80 \
	  askainet/docker-debian-repository


### Uploading packages

Fill your ``~/.dput.cf`` with the following content :

	[DEFAULT]
	default_host_main = docker

	[docker]
	fqdn = localhost
	method = scp
	login = user
	incoming = /docker/incoming
	ssh_config_options =
        	Port 49160
        	StrictHostKeyChecking no


Then upload the latest package you maintain :

	$ dput ~/src/foobar_0.1.10_amd64.changes
	Trying to upload package to docker
	Uploading to docker (via scp to 127.0.0.1):
	foobar_0.1.10_all.deb              100%   39KB  39.3KB/s   00:00
	foobar_0.1.10.dsc                  100%  488     0.5KB/s   00:00
	foobar_0.1.10.tar.gz               100%  826KB 826.0KB/s   00:00
	foobar_0.1.10_amd64.changes        100% 1488     1.5KB/s   00:00
	Successfully uploaded packages.


### Accessing the repository

Add the following line to your source list

	deb http://localhost:49161/debian stable main contrib non-free


Credits
-------

<!-- ![Gnuside](http://www.gnuside.com/wp-content/themes/gnuside-ignition-0.2-1-g0d0a5ed/images/logo-whitebg-128.png) -->

Based on the work of [Glenn Y. Rolland, aka Glenux](http://www.glenux.net)


License
-------

Debian-Repository for Docker is Copyright © 2014 Glenn Y. Rolland.

It is free software, and may be redistributed under the terms specified in the LICENSE file.

