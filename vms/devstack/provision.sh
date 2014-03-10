#!/bin/bash -x
#provisioner for centos 6 based box

dir=/home/vagrant/devstack

which git || yum -y install git
test -d $dir || {
	cd /home/vagrant 
	git clone https://github.com/openstack-dev/devstack.git
	chown -R vagrant.vagrant /home/vagrant/devstack
	echo "Now do vagrant ssh; ./devstack/stack.sh"
}
