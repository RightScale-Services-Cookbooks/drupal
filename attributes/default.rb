include_attribute "repo"
include_attribute "web_apache"
default[:drupal][:base_dir]="#{node[:repo][:default][:destination]}/#{node[:web_apache][:application_name]}"
default[:drupal][:settings][:file]=::File.join(node[:drupal][:base_dir], "sites/default/settings.php)
