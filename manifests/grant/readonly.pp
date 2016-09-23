# Defined Type to create Read-Only User
#
define vmyusers::grant::readonly (

  $dbauth,
  $dbauthpw,
  $user,
  $password,
  $database,
  $location,

) {

  exec { 'create_readonly_user':
    onlyif  => "/usr/bin/mysqladmin -u${user} -p\'${password}\' status",
    command => "/usr/bin/mysql --user=${dbauth} --password=${dbauthpw} -e \"GRANT SELECT ON ${database}.* TO \'${user}\'@\'${location}\' IDENTIFIED BY \'${password}\'; flush privileges;\"",
  }

}
