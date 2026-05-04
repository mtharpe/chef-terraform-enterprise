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

tfe = node['terraform_enterprise']
installer_path = "#{Chef::Config[:file_cache_path]}/install.sh"

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
  mode '0644'
  sensitive true
end

template '/etc/terraform.d/settings.json' do
  source 'settings.json.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    hostname: tfe['hostname'],
    install_type: tfe['install_type']
  )
end

cookbook_file '/etc/terraform.d/license.rli' do
  source "#{tfe['license_file_location']}/license.rli"
  owner 'root'
  group 'root'
  mode '0644'
  sensitive true
end

remote_file installer_path do
  source tfe['installer_url']
  owner 'root'
  group 'root'
  mode '0755'
  not_if { ::File.exist?(installer_path) }
  notifies :run, 'execute[install_ptfe]', :delayed
end

execute 'install_ptfe' do
  command "#{installer_path} no-proxy private-address=#{tfe['private_address']} public-address=#{tfe['public_address']}"
  action :nothing
  not_if "ss -ltn '( sport = :#{tfe['admin_console_port']} )' | grep -q LISTEN"
end

chef_sleep 'finalizing_setup' do
  seconds tfe['post_install_sleep']
  action :nothing
  subscribes :sleep, 'execute[install_ptfe]', :delayed
end
