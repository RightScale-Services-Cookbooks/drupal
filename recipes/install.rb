rightscale_marker :begin

package "#{node[:drupal][:php][:base_package]}" do
  action :install
end

package "#{node[:drupal][:php][:base_package]}-#{node[:drupal][:database][:driver]}" do
  action :install
end

package "#{node[:drupal][:php][:base_package]}-pecl-apc" do
  action :install
end

package "#{node[:drupal][:php][:base_package]}-gd" do
  action :install
end

package "#{node[:drupal][:php][:base_package]}-xml" do
  action :install
end

package "#{node[:drupal][:php][:base_package]}-mbstring" do
  action :install
end

drupal "default" do
  directory node[:drupal][:base_dir]
  action :install
end

drupal node[:drupal][:site_alias] do
  path node[:drupal][:base_dir]
  action :create_drush_alias
end

if node[:drupal][:database][:host] == "localhost"
  include_recipe "drupal::create_local_db"
  bash "local-install" do
    code <<-EOF
      drush si --db-url=#{node[:drupal][:database][:driver]}://#{node[:drupal][:database][:user]}:#{node[:drupal][:database][:password]}@#{node[:drupal][:database][:host]}/#{node[:drupal][:database][:schema]} --account-name #{node[:drupal][:admin][:user]} --account-pass #{node[:drupal][:admin][:password]}
    EOF
  end
end

rightscale_marker :end
