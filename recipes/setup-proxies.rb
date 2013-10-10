rightscale_marker :begin

drupal "setup-proxies" do
  directory node[:drupal][:settings][:multi_conf_dir]
  lb_ips node[:drupal][:proxy][:list]
  action :setup_proxies
end

rightscale_marker :end
