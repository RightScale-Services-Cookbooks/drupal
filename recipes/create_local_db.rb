rightscale_marker :begin

if node[:drupal][:database][:host] == "localhost"
  if node[:drupal][:database][:driver] == "mysql"
    p = package "mysql" do
          action :install
        end
    p.run_action(:install)

    g = chef_gem "mysql" do
          action :nothing
        end
    g.run_action(:install)

    bash "create db and user" do
      code <<-EOF
        mysqladmin -u root create #{node[:drupal][:database][:schema]}
        mysql -u root -e "GRANT ALL ON #{node[:drupal][:database][:schema]} TO #{node[:drupal][:database][:user]} IDENTIFIED BY #{node[:drupal][:database][:password]}; FLUSH PRIVILEGES;"
      EOF
      only_if { 'mysql -u root -e "SELECT VERSION();' }
    end
  elsif node[:drupal][:database][:driver] == "pgsql"
    log "not implemented yet"
  end
end

rightscale_marker :end  
