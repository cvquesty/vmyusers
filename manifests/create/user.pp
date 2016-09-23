# Defined Type to create a user under MySQL
#
define vmyusers::create::user (

  $dbauth,
  $dbauthpw,
  $user,
  $database,

) {

  exec { 'create_user':
    command => "/bin/mysqladmin -u ${dbauth} -p ${dbauthpw} -e \"CREATE USER ${user} ON ${database}.*\"",
  }

}
