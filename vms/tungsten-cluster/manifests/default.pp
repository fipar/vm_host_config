node default {
	include percona
}

class percona {

# include the percona yum repo
 $releasever = "6"
 $basearch = $hardwaremodel
	yumrepo { 
        "percona":
            descr       => "Percona",
            enabled     => 1,
            baseurl     => "http://repo.percona.com/centos/$releasever/os/$basearch/",
            gpgcheck    => 0;
	}

        package {
                "Percona-Server-server-55.$hardwaremodel":
                        alias => "MySQL-server",
                        require => [ Yumrepo['percona'], Package['MySQL-client'] ],
                        ensure => "installed";
                "Percona-Server-client-55.$hardwaremodel":
                        alias => "MySQL-client",
                        require => Yumrepo['percona'],
                        ensure => "installed";
		"rsync":
			ensure => "installed";
		"ruby":
			ensure => "installed";
		"java-1.6.0-openjdk":
			ensure => "installed";

        }
# include the my.cnf file

	file {
		"/etc/my.cnf":
			ensure => present,
			content => template("/tmp/vagrant-puppet/modules-0/percona/templates/my.cnf.erb"),
	}

# copy the tungsten install script

	file {
		"/root/tungsten-replicator-2.1.0-346.tar.gz":
			ensure  => present,
			source => "/tmp/vagrant-puppet/modules-0/tungsten/tungsten-replicator-2.1.0-346.tar.gz",	
	}

# init the datadir
	exec { "/usr/bin/mysql_install_db --datadir /var/lib/mysql":
		creates => "/var/lib/mysql/mysql/user.MYD",
		logoutput => true,
		require => Package['MySQL-server'],
	} 


# start mysql
	exec { "/etc/init.d/mysql start": 
		logoutput => true,
		require => [ Package['MySQL-server'], Exec['/usr/bin/mysql_install_db --datadir /var/lib/mysql'] ]	
	}


# stop iptables 
	exec { "/etc/init.d/iptables stop":
		logoutput => true,
	}
}
## individual nodes


