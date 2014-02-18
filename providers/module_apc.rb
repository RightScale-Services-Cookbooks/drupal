action :install do
  package node[:drupal][:module_apc][:package] do
    action :install
  end

  template "/etc/php.d/apc.ini" do
    source "modules/apc/apc.ini.erb"
    owner "root"
    group "root"
    mode "0644"
    action :install
  end

end

action :configure do
  directory_txt=@new_resource.directory
  raise "Can not create settings file" if directory_txt.nil?

  drupal "install-apc" do
    site_alias site_alias_txt
    directory directory
    module_name "apc"
    actions [ :download_module, :install_module ]
  end

  directory "#{directory_txt}/sites/default/local_settings" do
    owner "root"
    group "root"
    mode "0755"
    action :create
  end
  
  template "#{directory_txt}/sites/default/local_settings/apc.php" do
    source "modules/apc/apc.php.erb"
    owner "root"
    group "root"
    mode "0664"
    action :create
  end
  
end
