class boot(
            $manage_package  = true,
            $bootup          = 'color',
            $rescol          = '60',
            $prompt          = false,
            $autoswap        = false,
            $active_consoles = '/dev/tty[1-6]',
            $single          = '/sbin/sulogin',
          ) inherits boot::params{

  class { '::boot::install': } ->
  class { '::boot::config': } ->
  Class['::boot']

}
