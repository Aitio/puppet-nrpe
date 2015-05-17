class nrpe::service inherits nrpe {
    if ! ($nrpe::service_ensure in [ 'running', 'stopped' ]) {
        fail('service_ensure parameter must be running or stopped')
    }

    if $nrpe::service_manage == true {
        service { 'nrpe':
            ensure => $nrpe::service_ensure,
            enable => $nrpe::service_enable,
            name => $nrpe::service_name,
            hasstatus    => true,
            hasrestart => true,
        }
    }
}
