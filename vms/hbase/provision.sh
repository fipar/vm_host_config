#!/bin/bash -x
#provisioner for centos 6 based box

# use this in case you want pseudo-distributed operation
#  <property>
#   <name>hbase.cluster.distributed</name>
#   <value>true</value>
#  </property>

HBASE_HOME=/home/vagrant/opt/hbase-0.94.16

[ -d /home/vagrant/opt/hbase ] || { 
    yum -y update
    yum -y install java-1.7.0-openjdk java-1.7.0-openjdk-devel
    cd /home/vagrant
    # next line in case the file is already provided
    [ -f /home/vagrant/hbase-0.94.16.tar.gz ] || wget http://apache.mirrors.lucidnetworks.net/hbase/hbase-0.94.16/hbase-0.94.16.tar.gz
    mkdir /home/vagrant/opt/; cd /home/vagrant/opt
    tar xzvf /home/vagrant/hbase-0.94.16.tar.gz && rm -f /home/vagrant/hbase-0.94.16.tar.gz
    mkdir -p /data/hbase
    mkdir /data/zookeeper
    echo "export HBASE_HOME=$HBASE_HOME" >> /home/vagrant/.bashrc
    echo 'export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.51.x86_64/' >> $HBASE_HOME/conf/hbase-env.sh 
    echo 'export HBASE_MANAGES_ZK=false' >> $HBASE_HOME/conf/hbase-env.sh 
cat > $HBASE_HOME/conf/hbase-site.xml <<EOF
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
  <property>
    <name>hbase.rootdir</name>
    <value>file:///data/hbase</value>
  </property>
  <property>
    <name>hbase.zookeeper.property.dataDir</name>
    <value>/data/zookeeper</value>
  </property>
</configuration>
EOF

    $HBASE_HOME/bin/start-hbase.sh
}


