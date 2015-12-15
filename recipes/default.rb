#
# Cookbook Name:: drupal
# Recipe:: default
#
# Copyright 2013, RightScale Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
rightscale_marker :begin

# Download composer
#remote_file '/usr/local/bin/composer' do
#  source 'https://getcomposer.org/installer|php'
#  owner 'root'
#  group 'root'
#  mode 0755
#  action :create
#end

##Installing Drush
#execute 'composer global require drush/drush:7.1.0'
# action :run
#end

 #curl -sS https://getcomposer.org/installer | php
  #mv composer.phar /usr/local/bin/composer
  #export PATH="$HOME/.composer/vendor/bin:$PATH"
  
  include_recipe "composer::default"
  include_recipe "composer::global_configs"
# Installing composer
bash 'install_drush' do
  user 'root'
  flags '-ex'
  code <<-EOH
  /usr/local/bin/composer global require drush/drush:7.1.0
  drush status
  EOH
end

rightscale_marker :end