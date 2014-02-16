#!/bin/bash -x
#provisioner for centos 6 based box

rpm -qa|grep couchdb>/dev/null || {
    wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
    rpm -ivh epel-release-6-8.noarch.rpm
    yum -y update
    yum -y install couchdb 
    chkconfig couchdb on
    service couchdb start 
}


