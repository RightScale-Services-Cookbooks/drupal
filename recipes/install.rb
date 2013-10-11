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

drupal "localhost" do
  path node[:drupal][:base_dir]
  action :create_drush_alias
end

node[:drupal][:site_alias]="localhost"

rightscale_marker :end
