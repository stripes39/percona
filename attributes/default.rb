#
# Cookbook Name:: percona
# Attribute:: default
#
# Copyright 2012, Myplanet Digital, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

# Options are: 5.0, 5.1, 5.5, latest
default['percona']['version'] = "5.5"

# Percona doesn't use upstart like vanilla MySQL does.
normal['mysql']['use_upstart'] = false

case node['platform']
when "ubuntu", "debian"
  case node['percona']['version']
  when "5.0"
    normal['mysql']['client']['packages'] = %w{percona-sql-client}
    normal['mysql']['server']['packages'] = %w{percona-sql-server}
  when "5.1", "5.5", "5.6"
    normal['mysql']['client']['packages'] = %W{percona-server-client-#{node['percona']['version']}}
    normal['mysql']['server']['packages'] = %W{percona-server-server-#{node['percona']['version']}}
  when "latest"
    normal['mysql']['client']['packages'] = %w{percona-server-client}
    normal['mysql']['server']['packages'] = %w{percona-server-server}
  end
end

