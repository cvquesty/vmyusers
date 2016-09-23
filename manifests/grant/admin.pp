# Defined Type to create Admin Uer
#
define vmyusers::grant::admin (

  $dbauth,
  $dbauthpw,
  $user,
  $password,
  $database,
  $location,

) {

  exec { 'create_admin_user':
    unless  => "/usr/bin/mysqladmin -u${user} -p\'${password}\' status",
    command => "/usr/bin/mysql --user=${dbauth} --password=${dbauthpw} -e \"GRANT ALL ON ${database}.* TO \'${user}\'@\'${location}\' IDENTIFIED BY \'${password}\'; flush privileges;\"",
  }

}
