class boot::install inherits boot {

  if($boot::manage_package)
  {
    package { $boot::params::package_name:
      ensure => 'installed',
    }
  }

}
