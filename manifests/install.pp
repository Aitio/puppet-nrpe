class nrpe::install inherits nrpe {
    if $nrpe::package_manage == true {
        package { $nrpe::package_name:
            ensure => present,
        }
    }
}
