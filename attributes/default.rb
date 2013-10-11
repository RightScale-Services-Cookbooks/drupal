include_attribute "repo"
include_attribute "web_apache"

default[:drupal][:base_dir]="#{node[:repo][:default][:destination]}/#{node[:web_apache][:application_name]}"
default[:drupal][:settings][:file]=::File.join(node[:drupal][:base_dir], "sites/default/settings.php")
default[:drupal][:settings][:multi_conf_dir]=::File.join(node[:drupal][:base_dir], "sites/default/local_settings/")
default[:drupal][:php][:base_package]="php53u"


#proxies
default[:drupal][:proxy][:pool_name]="default"
default[:drupal][:proxy][:list]=Array.new
