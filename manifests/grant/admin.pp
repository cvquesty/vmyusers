# Defined Type to create Admin User
# To call this defined type, you simply need source it from a profile
# or higher-scoped manifest as follows:
#
#  vmyusers::grant::admin { $name:
#    dbauth   => 'dbuser',   <- Administrative user in MySQL
#    dbauthpw => 'dbauthpw', <- Administrative user's password
#    user     => 'username', <- User you wish to grant access to
#    password => 'password', <- User's password you are creating
#    database => 'dbname',   <- Database you are granting access to
#    location => 'location', <- Host from which to give the new user access
#  }

# This routine runs a simple MySQL command line to add a user and give it
# admin access.  This "location" parameter can be 'localhost' or '%',
# whichever is needed for your particular purposes.
define vmyusers::grant::admin (

  $dbauth,
  $dbauthpw,
  $user,
  $password,
  $database,
  $location,

) {

  exec { 'flush_for_admin':
    onlyif    => "/usr/bin/mysqladmin -u${user} -p\'${password}\' status",
    command   => "/usr/bin/mysql --user=${dbauth} --password=${dbauthpw} -e \"REVOKE ALL PRIVILEGES,GRANT OPTION FROM \'${user}\'@\'${location}\'; FLUSH PRIVILEGES;\"",
    logoutput => false,
  }

  exec { 'create_admin_user':
    onlyif    => "/usr/bin/mysqladmin -u${user} -p\'${password}\' status",
    command   => "/usr/bin/mysql --user=${dbauth} --password=${dbauthpw} -e \"GRANT ALL ON ${database}.* TO \'${user}\'@\'${location}\' IDENTIFIED BY \'${password}\'; FLUSH PRIVILEGES;\"",
    logoutput => false,
    require   => Exec[ 'flush_for_admin' ],
  }

}
