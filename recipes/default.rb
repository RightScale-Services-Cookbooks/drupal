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
  
# Installing composer
bash 'install_composeranddrush' do
  user 'root'
  flags '-ex'
  code <<-EOH
  curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
  /usr/local/bin/composer global require drush/drush:7.1.0
  /root/.composer/vendor/bin/drush status
  EOH
end

#create a symbolic link to drush command
link '/root/.composer/vendor/bin/drush' do
  to '/usr/local/bin/drush'
end

rightscale_marker :end