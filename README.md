iptables
========

iptables puppet management via rules that are placed in fragment files and
assembled by the utility /usr/sbin/rebuild-iptables

iptables::rule

This definition drops a file representing that
rule or set of rules into /etc/iptables.d and then relies on
rebuild-iptables (provided by stanford-server) to generate the merged rule
set and update the running iptables restrictions.

Usage:

     iptables::rule { '<name>':
         ensure      => present | absent,
         description => '<description>',
         source      => [ '<ip-or-range>', '<ip-or-range>', ... ],
         port        => [ '<port>', '<port>', ... ],
         protocol    => [ 'tcp' | 'udp', ... ],
         target      => 'ACCEPT' | 'REJECT' | '<chain>'
     }

Multiple ports, multiple sources, and multiple protocols can be specified.
If only one is given, the [] brackets are optional.  Description (optional)
is used to generate a comment at the top of the file and has no other
semantic meaning.

Protocol and port are required.  Source is optional; if omitted, connections
from any source are allowed.  The default target is ACCEPT.

Examples:

        include iptables

        iptables::rule { 'web':
          ensure     => present,
          desription => 'Allow web server access from all IPs',
          protocol   => 'tcp',
          port       => ['80','443'],
        }


This module assumes:

- You have `/usr/sbin/rebuild-iptables` and a `stanford-server` package for
  Debian/Ubuntu or RHEL.  See the `rebuild-iptables` github repo for source.


License

The iptables puppet module is released under the following license:

    Copyright 2011, 2012, 2013 
    The Board of Trustees of the Leland Stanford Junior University.

    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
    DEALINGS IN THE SOFTWARE. 
