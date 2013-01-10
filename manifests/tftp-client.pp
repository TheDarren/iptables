# iptables configuration for servers which want to run tftp client

class iptables::tftp-client inherits iptables {
    case $lsbdistcodename {
        # lenny, squeeze use a different name
        "lenny","squeeze": {
            os::kernel-module { "nf_conntrack_tftp":
                ensure => present,
            }
        }
        default: {
            os::kernel-module { "ip_conntrack_tftp":
                ensure => present,
            }
        }
    }
}
