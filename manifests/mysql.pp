# Class to setup mysql
#
class vmyusers::mysql {

  class { '::mysql::server':
    root_password           => 'rootpw',
    remove_default_accounts => true,
  }

}
