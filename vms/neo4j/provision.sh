#!/bin/bash -x
#provisioner for centos 6 based box

dpkg -l|grep neo4j>/dev/null || {
	wget -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add - 
	echo 'deb http://debian.neo4j.org/repo stable/' > /etc/apt/sources.list.d/neo4j.list
	apt-get update
	apt-get install neo4j 
	echo 'neo4j start' >> /etc/rc.local
	neo4j start 
}
