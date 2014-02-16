#!/bin/bash -x
#provisioner for centos 6 based box

rpm -qa|grep mongo>/dev/null || {
cat > /etc/yum.repos.d/mongodb.repo <<EOF
[mongodb]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/
gpgcheck=0
enabled=1
EOF
    yum -y update
    yum -y install mongo-10gen mongo-10gen-server
    chkconfig mongod on
    service mongod start 
}


