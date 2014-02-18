action :install do
  site_alias_str=@new_resource.site_alias
  directory_str=@new_resource.directory

  package node[:drupal][:module_memcache][:package] do
    action :install
  end

  drupal "install-memcache" do
    site_alias site_alias_str
    directory directory
    module_name "memcache"
    actions [ :download_module, :install_module ]
  end

end

action :configure do
  directory_str=@new_resource.directory
  memcache_server_str=@new_resource.memcache_server
  sessions_enabled=@new_resource.enable_session

  raise "Can not create settings file" if directory_str.nil? 
  
  template "/etc/php.d/memcache.ini" do
    source "modules/memcache/memcache.ini.erb"
    owner "root"
    group "root"
    mode "0644"
    variables( :memcache_server => memcache_server_str,
               :session => sessions_enabled )
    action :create
  end

  directory "#{directory_str}/sites/default/local_settings" do
    owner "root"
    group "root"
    mode "0755"
    action :create
  end
  
  template "#{directory_str}/sites/default/local_settings/memcache.php" do
    source "modules/memcache/memcache.php.erb"
    owner "root"
    group "root"
    mode "0664"
    variables(:memcache_server => memcache_server_str)
    action :create
  end
  
end
