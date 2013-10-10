rightscale_marker :begin

template "#{node[:drupal][:settings][:multi_conf_dir]}/memcache.php" do
  cookbook "drupal"
  source "memcache.php.erb"
  owner "apache"
  group "apache"
  mode "0644"
  variables( :memcache_prefix => "drup_",
             :memcache_servers => node[:drupal][:memcache_servers])
  action :create
end

rightscale_marker :end 
