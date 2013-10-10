action :install do
  install_directory=@new_resource.directory

  remote_file "/tmp/drupal.tar.gz" do
    source "http://ftp.drupal.org/files/projects/drupal-7.23.tar.gz"
    owner "root"
    group "root"
    mode "0644"
    checksum "79f2ae06aac349b86fc0f6cd100f3fc34b72e9f46068ddf704d575778aae1f99"
    action :create
  end
  
  execute "tar -xvzf /tmp/drupal.tar.gz -C #{install_directory}"

end

action :create_drush_alias do
  directory "/etc/drush" do
    owner "root"
    group "root"
    mode "0644"
    action :create
    not_if "test -e /etc/drush"
  end

  Chef::Log.info "Adding Alias for domain name(#{@new_resource.domain_name}) with path(#{@new_resource.path})"
  domain_name = @new_resource.domain_name
  path = @new_resource.path

  template "/etc/drush/#{@new_resource.domain_name}.aliases.drushrc.php" do
    cookbook "drupal"
    source "aliases.drushrc.php.erb"
    owner "root"
    group "root"
    mode "0644"
    backup false
    variables( :domain_name => domain_name,
               :path => path )
    action :create
  end
end

action :download_module do
  site_alias=@new_resource.site_alias
  module_name=@new_resouce.module_name
  execute "drush #{site_alias} dl #{module_name}"
end

action :install_module do
  site_alias=@new_resource.site_alias
  module_name=@new_resouce.module_name
  execute "drush #{site_alias} -y en #{module_name}"
end

action :clear_cache do
  site_alias=@new_resource.site_alias
  if !site_alias.nil?
    if site_alias[0] != '@'
      site_alias = '@'+site_alias
    end
    Chef::Log.info "Clearing cache for alias #{site_alias}"
  end

  directory=@new_resource.directory
  if !directory.nil?
    dir_string="cd #{directory};"
  end
  execute "#{dir_string} drush #{site_alias} cc all"
end

action :generate_settings do
  settings_file=@new_resource.settings_file
  directory "#{::File.dirname(settings_file)}/local_settings/" do
    owner "root"
    group "root"
    mode "0644"
    action :create
  end
  
  template "#{@new_resource.settings_file}" do
    cookbook "drupal"
    source "settings.php.erb"
    owner "root"
    group "root"
    mode "0644"
    variables(  :database_driver => @new_resource.database_driver,
                :database_schema => @new_resource.database_schema,
                :database_user => @new_resource.database_user,
                :database_password => @new_resource.database_password,
                :database_host => @new_resource.database_host,
                :database_port => @new_resource.database_port,
                :database_table_prefix => @new_resource.database_table_prefix )
    action :create
  end
end

action :setup_proxies do
    settings_directory=@new_resource.settings_directory
    lb_ip=@new_resource.lb_ip

    directory "#{settings_directory}" do
      owner "apache"
      group "apache"
      mode "0644"
      action :create
      not_if "test -d #{settings_directory}"
    end

    Chef::Log.info "ips: #{lb_ip}"
    template "#{settings_directory}/proxies.php" do
      cookbook "drupal"
      source "proxies.php.erb"
      owner "apache"
      group "apache"
      mode "0644"
      backup false
      variables( :lb_ip => lb_ip )
      action :create
      only_if { lb_ip }
    end
end
