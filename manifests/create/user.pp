# Defined Type to create a user under MySQL
# To call this defined type, you simply need source it from a profile
# or higher-scoped manifest as follows:
#
# vmyusers::create::user { 'username':
#   dbauth   => 'dbuser',    <- Administrative user in MySQL
#   dbauthpw => 'dbauthpw',  <- Administrative user's password
#   user     => 'username',  <- User you wish to create
#   password => 'passsword', <- User's password you are creating
#   location => 'location',  <- host from which to give the new user access
# }
#
# This routine runs a simple MySQL command line to add a user and give it
# general access.  This "location" parameter can be 'localhost' or '%',
# whichever is needed for your particular purposes.
#
define vmyusers::create::user (

  $dbauth,
  $dbauthpw,
  $user,
  $password,
  $location,

) {

  exec { 'create_user':
    unless  => "/usr/bin/mysqladmin -u${user} -p\'${password}\' status",
    command => "/usr/bin/mysql --user=${dbauth} --password=${dbauthpw} -e \"CREATE USER ${user}@${location} IDENTIFIED BY \'${password}\'\"",
  }

}
