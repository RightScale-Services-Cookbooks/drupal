rightscale_marker :begin

node[:drupal][:module][:list].split(' ').each do |mod|
  drupal mod do
    site_alias node[:drupal][:site_alias]
    module_name mod
    action [ :download_module, :enable_module ]
  end
end

rightscale_marker :end
