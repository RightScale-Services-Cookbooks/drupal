#clears the drupal cache
actions :clear_cache
  attribute :site_alias, :kind_of => String, :default => nil
  attribute :directory, :kind_of => String, :default => nil

actions :generate_settings
  #generic
  attribute :settings_file, :kind_of => String, :default => "/home/webapps/myapp/sites/default/settings/settings.php"

  #database attributes
  attribute :database_driver, :kind_of => String, :default => "mysql"
  attribute :database_schema, :kind_of => String
  attribute :database_user, :kind_of => String
  attribute :database_password, :kind_of => String
  attribute :database_host, :kind_of => String
  attribute :database_port, :kind_of => String, :default => "3306"
  attribute :database_table_prefix, :kind_of => String

actions :create_drush_alias
  attribute :domain_name, :kind_of => String, :name_attribute => true
  attribute :path, :kind_of => String

actions :download_module, :enable_module
  attribute :module_name, :kind_of => String, :name_attriute => true

actions :install
