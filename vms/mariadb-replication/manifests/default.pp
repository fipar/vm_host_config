node default {
	include mariadb
}

class mariadb {

# include the MariDB yum repo
 $releasever = "6"
 $basearch = $hardwaremodel
	yumrepo { 
        "MariaDB":
            descr       => "MariaDB",
            enabled     => 1,
            baseurl     => "http://yum.mariadb.org/5.5/centos5-x86",
            gpgcheck    => 0;
	}

# include the packages needed for MariaDB
        package {
                "MariaDB-server":
                        alias => "MariaDB-server",
                        require => [ Yumrepo['MariaDB'], Package['MariaDB-client'] ],
                        ensure => "installed";
                "MariaDB-client":
                        alias => "MariaDB-client",
                        require => Yumrepo['MariaDB'],
                        ensure => "installed";
        }

}



node maria inherits default {

}

