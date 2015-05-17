class nrpe::config inherits nrpe {
    file { $nrpe::config:
        ensure => file,
        owner => 0,
        group => 0,
        mode => '0644',
        content => template($nrpe::config_template),
    }

# After the following issue has been fixed, replace the next
# hack with the firewall definition below:
# https://tickets.puppetlabs.com/browse/MODULES-1244
    define firewall_nrpe() {
        firewall { "010 Allow NRPE connections from ${title}":
            proto => tcp,
            dport => 5666,
            source => $title,
            action => accept,
        }
    }


    if $nrpe::firewall_manage == true {
        firewall_nrpe { $nrpe::allowed_hosts: }

#        firewall { "010 Allow NRPE connections from Nagios":
#            port => 5666,
#            proto => tcp,
#            source => $nrpe::allowed_hosts,
#            action => accept,
#        }
    }
}
