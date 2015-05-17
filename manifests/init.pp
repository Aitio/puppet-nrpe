# == Class: nrpe
#
# Full description of class nrpe here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'nrpe':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class nrpe(
    $package_manage = $nrpe::params::package_manage,
    $package_name = $nrpe::params::package_name,
    $service_manage = $nrpe::params::service_manage,
    $service_name = $nrpe::params::service_name,
    $service_ensure = $nrpe::params::service_ensure,
    $service_enable = $nrpe::params::service_enable,
    $firewall_manage = $nrpe::params::firewall_manage,
    $allowed_hosts = [],
    $commands = {}
) inherits nrpe::params {
    # Validate configuration.
    validate_bool($package_manage)
    validate_string($package_name)
    validate_bool($service_manage)
    validate_string($service_name)
    validate_string($service_ensure)
    validate_bool($service_enable)
    validate_bool($firewall_manage)
    validate_array($allowed_hosts)
    validate_hash($commands)

    if empty($allowed_hosts) {
        fail("Must specify one or more allowed_hosts.")
    }
    if empty($commands) {
        fail("Must specify one or more commands.")
    }

    # Ensure proper processing order.
    anchor { 'nrpe::begin': } ->
    class { '::nrpe::install': } ->
    class { '::nrpe::config': } ~>
    class { '::nrpe::service': } ->
    anchor { 'nrpe::end': }
}
