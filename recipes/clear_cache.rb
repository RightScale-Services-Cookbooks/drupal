rightscale_marker :begin

drupal "clear" do
  directory node[:drupal][:base_dir]
  action :clear_cache
end

rightscale_marker :end
