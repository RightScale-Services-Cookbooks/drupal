rightscale_marker :begin

drupal "clear cache" do
  site_alias node[:drupal][:site_alias]
  action :clear_cache
end

rightscale_marker :end
