# Defined Type to create a user under MySQL
#
define vmyusers::create::user (

  $dbauth,
  $dbauthpw,
  $user,
  $password,
  $database,
  $location,

) {

  exec { 'create_user':
    unless  => "/usr/bin/mysqladmin -u${user} -p\'${password}\' status",
    command => "/usr/bin/mysql --user=${dbauth} --password=${dbauthpw} -e \"CREATE USER ${user}@${location} IDENTIFIED BY \'${password}\'\"",
  }

}
