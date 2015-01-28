rightscale_marker :begin

drupal "configure settings" do
  settings_file node[:drupal][:settings][:file]
  database_driver node[:drupal][:database][:driver]
  database_schema node[:drupal][:database][:schema]
  database_user node[:drupal][:database][:user]
  database_password  node[:drupal][:database][:password]
  database_host node[:drupal][:database][:host]
  database_port node[:drupal][:database][:port]
  database_table_prefix  node[:drupal][:database][:table_prefix]
  action :generate_settings
end

service "httpd" do
  action :restart
end

case node[:platform]
  when "centos","redhat"
    service "httpd" do
	  action :restart
  when "ubuntu","debian"
    service "apache2" do
      action :restart
  end
  
drupal "clear" do
  directory node[:drupal][:base_dir]
  action :clear_cache
end

rightscale_marker :end
