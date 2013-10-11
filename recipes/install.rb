rightscale_marker :begin


drupal "default" do
  directory node[:drupal][:base_dir]
  action :install
end

drupal "localhost" do
  path node[:drupal][:base_dir]
  action :create_drush_alias
end

rightscale_marker :end
