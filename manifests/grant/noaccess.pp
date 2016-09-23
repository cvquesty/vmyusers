# Defined Type to create No-Access User
#
define vmyusers::grant::noaccess (

  $dbauth,
  $dbauthpw,
  $user,
  $password,
  $database,
  $location,

) {

  exec { 'create_noaccess_user':
    onlyif  => "/usr/bin/mysqladmin -u${user} -p\'${password}\' status",
    command => "/usr/bin/mysql --user=${dbauth} --password=${dbauthpw} -e \"REVOKE ALL ON ${database}.* FROM \'${user}\'@\'${location}\'; flush privileges;\"",
  }

}
