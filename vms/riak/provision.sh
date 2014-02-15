#!/bin/bash -x
#provisioner for centos 6 based box

rpm -qa|grep riak >/dev/null 2>&1 || {
    rpm -ivh http://yum.basho.com/gpg/basho-release-5-1.noarch.rpm
    yum -y update
    yum -y install riak 
}


