class boot::config inherits boot {

  concat { '/etc/sysconfig/init':
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  concat::fragment{ 'sysconfg/init base':
    target  => '/etc/sysconfig/init',
    order   => '00',
    content => template("${module_name}/sysconfig/init/base.erb"),
  }

  case $::osfamily
  {
    'redhat':
    {
      concat::fragment{ 'sysconfg/init single':
        target  => '/etc/sysconfig/init',
        order   => '10',
        content => template("${module_name}/sysconfig/init/single.erb"),
      }

      case $::operatingsystemrelease
      {
        /^6.*$/:
        {
          concat::fragment{ 'sysconfg/init 6 specific':
            target  => '/etc/sysconfig/init',
            order   => '01',
            content => template("${module_name}/sysconfig/init/6.erb"),
          }
        }
        /^7.*$/:
        {
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    default:
    {
      fail('Unsupported')
    }
  }


}
