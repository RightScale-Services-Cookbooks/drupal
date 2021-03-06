name             'drupal'
maintainer       'RightScale Inc'
maintainer_email 'premium@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures drupal'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.13'

depends "rightscale"
depends "repo"
depends "web_apache"
depends "app"
depends "app_php"

recipe "drupal::default", "sets up drupal"
recipe "drupal::install", "installs base drupal"
recipe "drupal::setup_cron_jobs", "sets up drupal cron jobs"
recipe "drupal::clear_cache", "clears drupal cache"
recipe "drupal::setup_file_conveyor", "installs fileconveyor"
recipe "drupal::do_config_settings-php", "config settings php"
recipe "drupal::setup-proxies", "configures proxies"
recipe "drupal::rightscale-setup-proxies", "uses rightscale tag system to setup proxies"
recipe "drupal::memcache", "configures memcache"
recipe "drupal::clear_cache_by_alias", "clears cache by alias"
recipe "drupal::create_local_db", "creates a local db"
recipe "drupal::module_installer", "Drupal Module Installer"

attribute "drupal/fileconveyor/username",
  :display_name => "FileConveyor Username", 
  :description => "FileConveyor Username",
  :required => "required",
  :recipes => [ "drupal::setup_file_conveyor" ]

attribute "drupal/fileconveyor/api_key",
  :display_name => "FileConveyor API Key",
  :description => "FileConveyor API Key",
  :required => "required",
  :recipes => [ "drupal::setup_file_conveyor" ]

attribute "drupal/database/driver",
  :display_name => "Drupal Database Driver",
  :description => "Drupal Database Driver",
  :required => "optional",
  :choice => [ "mysql", "pgsql" ],
  :default => "mysql",
  :recipes => [ "drupal::do_config_settings-php", "drupal::create_local_db" ]
  
attribute "drupal/database/schema",
  :display_name => "Drupal Database Schema",
  :description => "Drupal Database Schema",
  :required => "required",
  :recipes => [ "drupal::do_config_settings-php", "drupal::create_local_db" ]
  
attribute "drupal/database/user",
  :display_name => "Drupal Database User", 
  :description => "Drupal Database User",
  :required => "required",
  :recipes => [ "drupal::do_config_settings-php", "drupal::create_local_db" ]
  
attribute "drupal/database/password",
  :display_name => "Drupal Database Password",
  :description => "Drupal Database Password",
  :required => "required",
  :recipes => [ "drupal::do_config_settings-php", "drupal::create_local_db" ]
  
attribute "drupal/database/host",
  :display_name => "Drupal Database Host",
  :description => "Drupal Database Host",
  :required => "required",
  :recipes => [ "drupal::do_config_settings-php", "drupal::create_local_db" ]
  
attribute "drupal/database/port",
  :display_name => "Drupal Database Port",
  :description => "Drupal Database Port",
  :required => "optional",
  :default => "3306",
  :choice => [ "3306", "5432" ],
  :recipes => [ "drupal::do_config_settings-php", "drupal::create_local_db" ]
  
attribute "drupal/database/table_prefix",
  :display_name => "Drupal Database Table Prefix",
  :description => "Drupal Database Table Prefix",
  :required => "optional",
  :default => "",
  :recipes => [ "drupal::do_config_settings-php" ]

attribute "drupal/proxy/pool_name",
  :display_name => "Drupal LB Pool Name", 
  :description => "Drupal LB Pool Name",
  :required => "required",
  :recipes => [ "drupal::rightscale-setup-proxies" ]

attribute "drupal/memcache_servers",
  :display_name => "Memcache Servers",
  :description => "Memcache Servers",
  :required => "required",
  :recipes => [ "drupal::memcache" ]

attribute "drupal/site_alias",
  :display_name => "Drupal Site Alias",
  :description => "Drupal Site Alias",
  :required => "optional",
  :default => "localhost",
  :recipes => [ "drupal::clear_cache_by_alias", "drupal::install", "drupal::module_installer" ]

attribute "drupal/module/list",
  :display_name => "Drupal Module List",
  :description => "Drupal Module List",
  :required => "required",
  :recipes => [ "drupal::module_installer" ]

attribute "drupal/admin/user", 
  :display_name => "Drupal Admin User",
  :description => "Drupal Admin User",
  :required => "optional",
  :default => "admin",
  :recipes => [ "drupal::install" ]

attribute "drupal/admin/password",
  :display_name => "Drupal Admin Password",
  :description => "Drupal Admin Password",
  :required => "optional",
  :default => "admin",
  :recipes => [ "drupal::install" ]
