#
# Handles iptables concerns.  See also iptables::fragment definition

class iptables {
    package { 'iptables': ensure => present }

    exec { 'rebuild-iptables':
        command     => '/usr/sbin/rebuild-iptables',
        refreshonly => true,
        require     => Package['stanford-server'],
        unless      => '[ -e /etc/no-iptables ]',
    }

    # Make sure iptables on RHEL starts at boot time. Usually only an issue on
    # systems which have been puppetized in place and not rebuilt from scratch.
    case $operatingsystem {
        'redhat': {
            service { 'iptables':
                enable    => true,
                hasstatus => false,
            }
        }
    }

    file { '/etc/iptables.d':
        ensure  => directory,
        purge   => true,
        recurse => true,
        notify  => Exec['rebuild-iptables'],
    }
}

# Class that disables puppet management of iptables.
# You have to include both iptables and iptables::disabled if you want this to work.
class iptables::disabled {
    file {
        '/etc/no-iptables':
            ensure => file;
        '/etc/iptables':
            ensure => directory,
            owner  => 'root',
            group  => 'root';
    }
}
