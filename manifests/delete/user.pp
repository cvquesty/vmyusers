# Defined Type to delete a user under MySQL
# To call this defined type, you simply need source it from a profile
# or higher-scoped manifest as follows:
#
# vmyusers::delete::user { 'username':
#   dbauth   => 'dbuser',    <- Administrative user in MySQL
#   dbauthpw => 'dbauthpw',  <- Administrative user's password
#   user     => 'username',  <- User you wish to create
# }
#
# This routine runs a simple MySQL command line to add a user and give it
# general access.  This "location" parameter can be 'localhost' or '%',
# whichever is needed for your particular purposes.
#
define vmyusers::delete::user (

  $dbauth,
  $dbauthpw,
  $user,

) {

  exec { 'delete_user':
    onlyif  => "/usr/bin/mysql --user=${dbauth} --password=${dbauthpw} -e \"use mysql; SELECT ${user} FROM user;’ | grep ${user} \"",
    command => "/usr/bin/mysql --user=${dbauth} --password=${dbauthpw} -e \"DELETE FROM mysql.user WHERE User =\'${user}\';FLUSH PRIVILEGES;\"",
  }

}
