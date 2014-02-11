#!/bin/bash -x
#provisioner for centos 6 based box

[ -f /etc/yum.repos.d/pgdg-93-centos.repo ] || {
    rpm -ivh http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
    yum -y update
    yum -y install postgresql93 postgresql93-server postgresql93-contrib
}


