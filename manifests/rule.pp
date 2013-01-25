# Generate an iptables rule.  This definition drops a file representing that
# rule or set of rules into /etc/iptables.d and then relies on
# rebuild-iptables (provided by stanford-server) to generate the merged rule
# set and update the running iptables restrictions.
#
# Usage:
#
#     iptables::rule { '<name>':
#         ensure      => present | absent,
#         description => '<description>',
#         source      => [ '<ip-or-range>', '<ip-or-range>', ... ],
#         port        => [ '<port>', '<port>', ... ],
#         protocol    => [ 'tcp' | 'udp', ... ],
#         target      => 'ACCEPT' | 'REJECT' | '<chain>'
#     }
#
# Multiple ports, multiple sources, and multiple protocols can be specified.
# If only one is given, the [] brackets are optional.  Description (optional)
# is used to generate a comment at the top of the file and has no other
# semantic meaning. 
#
# Protocol is required.  Source and port are optional; if omitted, connections
# from any source or port are allowed.  Omitting source AND port is not
# allowed. The default target is ACCEPT.

define iptables::rule(
    $ensure      = 'present',
    $description = '',
    $source      = '',
    $port        = '',
    $protocol,
    $target      = 'ACCEPT'
) {
    if ($source == '' and $port == '') {
        fail "Iptables::Rule[$name] - you cannot omit both source and port"
    }
    file { "/etc/iptables.d/${name}":
        ensure  => $ensure,
        content => template('iptables/rule.erb'),
        notify  => Exec['rebuild-iptables'],
    }
}
