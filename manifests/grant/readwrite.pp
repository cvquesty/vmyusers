# Defined Type to create Admin Uer
#
define vmyusers::grant::readwrite (

  $dbauth,
  $dbauthpw,
  $user,
  $password,
  $database,
  $location,

) {

  exec { 'create_readwrite_user':
    onlyif  => "/usr/bin/mysqladmin -u${user} -p\'${password}\' status",
    command => "/usr/bin/mysql --user=${dbauth} --password=${dbauthpw} -e \"GRANT INSERT,SELECT,UPDATE ON ${database}.* TO \'${user}\'@\'${location}\' IDENTIFIED BY \'${password}\'; flush privileges;\"",
  }

}
