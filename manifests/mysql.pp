# Class to setup mysql
# Simple Callout to the puppetlabs-mysql module to install mysql
# with a specific root password and to remove the default accounts.
#
class vmyusers::mysql {

  class { '::mysql::server':
    root_password           => 'rootpw',
    remove_default_accounts => true,
  }

}
