rightscale_marker :begin

template "/home/webapps/myapp/sites/default/settings.php" do
  source "settings.php.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(   :database_driver => node[:drupal][:database][:driver],
               :database_schema => node[:drupal][:database][:schema],
               :database_user => node[:drupal][:database][:user],
               :database_password => node[:drupal][:database][:password],
               :database_host => node[:drupal][:database][:host],
               :database_port => node[:drupal][:database][:port],
               :database_table_prefix => node[:drupal][:database][:table_prefix] )
  action :create
end

service "httpd" do
  action :restart
end

drupal "clear" do
  action :clear_cache
end

rightscale_marker :end
