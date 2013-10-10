rightscale_marker :begin

results = rightscale_server_collection "load_balancers" do
  tags ["loadbalancer:#{node[:drupal][:proxy][:pool_name]}=lb"]
  secondary_tags ["server:private_ip_0=*"]
  empty_ok false
  action :nothing
end

results.run_action(:load)
if node["server_collection"]["load_balancers"]
  Chef::Log.info "Server Collection Found"
  node["server_collection"]["load_balancers"].to_hash.values.each do |tags|
    node[:drupal][:proxy][:list].push(RightScale::Utils::Helper.get_tag_value("server:private_ip_0", tags))
  end
else
  Chef::Log.info "No results found"
end

if !node[:drupal][:proxy][:list].nil? 
  include_recipe "drupal::setup-proxies"
end

rightscale_marker :end
