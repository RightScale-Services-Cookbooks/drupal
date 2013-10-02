
action :clear_cache do
  execute "cd #{new_resource.directory}; drush cc all"
end

action :generate_settings do
  settings_file=@new_resource.settings_file
  directory "#{::File.dirname(settings_file)}/local_settings/" do
    owner "root"
    group "root"
    mode "0644"
    action :create
  end
  
  template "#{@new_resource.settings_file}" do
    cookbook "drupal"
    source "settings.php.erb"
    owner "root"
    group "root"
    mode "0644"
    variables(  :database_driver => @new_resource.database_driver,
                :database_schema => @new_resource.database_schema,
                :database_user => @new_resource.database_user,
                :database_password => @new_resource.database_password,
                :database_host => @new_resource.database_host,
                :database_port => @new_resource.database_port,
                :database_table_prefix => @new_resource.database_table_prefix )
    action :create
  end
end

