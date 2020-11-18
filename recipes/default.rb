#
# Cookbook:: terraform_enterprise
# Recipe:: default
#
# Copyright:: 2020, HashiCorp
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

directory '/etc/terraform.d' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/etc/replicated.conf' do
  source 'replicated.conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/etc/terraform.d/settings.json' do
  source 'settings.json.erb'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

remote_file "#{Chef::Config['file_cache_path']}/install.sh" do
  source 'https://install.terraform.io/ptfe/stable'
  owner 'root'
  group 'root'
  mode '0766'
  action :create
  notifies :run, 'execute[install_ptfe]', :delayed
  not_if '`netstat -ant |grep LIST |grep 8800`'
end

cookbook_file '/etc/terraform.d/license.rli' do
  source "#{node['terraform_enterprise']['license_file_location']}/license.rli"
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

execute 'install_ptfe' do
  command "#{Chef::Config['file_cache_path']}/install.sh no-proxy private-address=#{node['ipaddress']} public-address=#{node['ipaddress']}"
  action :nothing
end

chef_sleep 'finalizing_setup' do
  seconds '410'
  action :nothing
  subscribes :sleep, 'execute[install_ptfe]', :delayed
end
