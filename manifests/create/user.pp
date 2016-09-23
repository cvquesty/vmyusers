# Defined Type to create a user under MySQL
#
define vmyusers::create::user (

  $dbauth,
  $dbauthpw,
  $user,
  $database,
  $location,

) {

  exec { 'create_user':
    command => "/usr/bin/mysql --user=${dbauth} --password=${dbauthpw} -e \"CREATE USER ${user}@${location}\"",
  }

}
