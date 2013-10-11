bash "create site with drush" do
  code <<-EOF
    drush @#{node[:drupal][:site_alias]} --db-url=mysql://drupal:drupal@localhost/drupal1 --account-pass=drupal
  EOF
end
