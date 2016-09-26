#### Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with vmyusers](#setup)
    * [What vmyusers affects](#what-vmyusers-affects)
    * [Beginning with vmyusers](#beginning-with-vmyusers)
3. [Usage](#usage)
4. [Reference - How to use vmyusers](#reference)


## Overview

This module is designed to provide functions to:

- Quickly create a database (if needed)
- Quickly add a new user and grant her specific levels of access

## Setup

### What vmyusers affects

vmyusers can affect any existing MySQL, Percona, or MariaDB implementation.  The user should be aware of they are affecting users already in existence, and should also note whether the MySQL flavor is already installed before sourcing the installation routines.  

### Setup Requirements

None.

### Beginning with vmyusers

If you are using Roles & Profiles with R10k or Code Manager, you must first commit the vmyusers module to your Git repository, and add it to your profiles to call the module.

If you are _not_ using the above, it can simply be extracted into your $moduledir for the environment you wish to implement it in.

## Usage

As mentioned above, there are two operational modes with which to use this module.  The first is to install the db itself if needed.  It is understood that this module may be introduced in a more mature environment, thus MySQL may already be installed.  As such, the module allows for being called with and without the installation components.

## Reference

### Installing MySQL

To install MySQL, somply include the module from a higher-scoped location such as node classification in site.pp or via an ENC.  You may also call the module from a higher-level via the Roles/Profiles design pattern:

	include [ '::vmyusers' ]
	include [ '::vmyusers::mysql' ]

Either of the above work. The first one includes the entire module, yes, but that simply calls the init.pp, which loads the ::vmyusers::mysql manifest. They are functionally the same.

### Adding the user

THe second function the vmyusers module provides is to add a user to the database.  Given how MySQL grant tables work, it was necessary to provide one routine for adding a user, one for granting or revoking it access, and one for removing it altogether.  To add a user, again, the routine must be called from a higher scope such as node scope in site.pp or the Roles/Profiles design pattern:

	vmyusers::create::user { $name:
	  dbauth   => 'root',
	  dbauthpw => 'rootpw',
	  user     => 'username',
	  password => 'userpass',
	  location => '%',
	}

**NOTES:** You will notice the use of a resource value of "$name" on the first line.  Every Defined Type carries with it two "free" parameters: $title and $name.  These parameters are always available and do not have to explicitly be added to the definition.  However, when running linters and parse checkers, sometimes they will choke on having a defined type call without a value on the first line.  By specifying the free parameter, it helps you avoid duplicate resource declaration by being dynamic to the defined type.  More information can be found [here](https://docs.puppet.com/puppet/latest/reference/lang_defined_types.html#title-and-name).

### Granting Rights to the User

The next feature of the modle is to apply grants against the user you created above.  To do this, you simply call that defined type as above, supplying the necessary parameters and values as appropriate:

	vmyusers::grant::readwrite { $name:
	  dbauth   => 'root',
	  dbauthpw => 'rootpw',
	  user     => 'username',
	  password => 'userpass',
	  database => 'database',
	  location => 'localhost',
	}

The instantiation is largely the same.  The main difference is the addition of a "database" parameter to specify the database you wish the user to have access to.  You will also notice in this example, the user is only granted access from "localhost".  Any vlue that is syntactically appropriate to MySQL/MariaDB/Percona should work here.

### Removing a User

The other main funciton this module provides is to remove a user completely. To do this, one simply need call the defined type, supplying the username to achieve this end.

	vmyusers::delete::user { $name:
	  user => 'username',
	}

This simply passes in the user to the deletion routine for full removal from the database.

**NOTE: You should enure the user oes not have rights or needs on any other database before using this particular defined type.  If you use this, the user is removed from the database _completely_.**