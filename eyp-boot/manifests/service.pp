class boot::service inherits boot {

  #
  validate_bool($boot::manage_docker_service)
  validate_bool($boot::manage_service)
  validate_bool($boot::service_enable)

  validate_re($boot::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${boot::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $boot::manage_docker_service)
  {
    if($boot::manage_service)
    {
      service { $boot::params::service_name:
        ensure => $boot::service_ensure,
        enable => $boot::service_enable,
      }
    }
  }
}
