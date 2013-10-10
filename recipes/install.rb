rightscale_marker :begin

drupal "default" do
  directory node[:drupal][:base_dir]
  action :install
end

rightscale_marker :end
