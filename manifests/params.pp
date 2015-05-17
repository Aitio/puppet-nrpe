class nrpe::params {
    $package_manage = true
    $package_name = 'nrpe'
    
    $service_manage = true
    $service_name = 'nrpe'
    $service_ensure = running
    $service_enable = true

    $firewall_manage = true

    $config = '/etc/nagios/nrpe.conf'
    $config_template = 'nrpe/nrpe.conf.erb'

    case $::osfamily {
        'RedHat': {
        }
        default: {
            fail("The ${module_name} module is not supported on a ${::osfamily} based system.")
        }
    }
}
