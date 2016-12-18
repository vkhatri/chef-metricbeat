#
# Cookbook Name:: metricbeat
# Recipe:: install
#
# Copyright 2015, Virender Khatri
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

metricbeat_arch = node['kernel']['machine'] =~ /x86_64/ ? 'x86_64' : 'x86'
package_url = node['metricbeat']['package_url'] == 'auto' ? "https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-#{node['metricbeat']['version']}-windows-#{metricbeat_arch}.zip" : node['metricbeat']['package_url']
package_file = ::File.join(Chef::Config[:file_cache_path], ::File.basename(package_url))

remote_file 'metricbeat_package_file' do
  path package_file
  source package_url
  not_if { ::File.exist?(package_file) }
end

directory node['metricbeat']['windows']['base_dir'] do
  recursive true
  action :create
end

windows_zipfile node['metricbeat']['windows']['base_dir'] do
  source package_file
  action :unzip
  not_if { ::File.exist?(node['metricbeat']['windows']['base_dir'] + "/metricbeat-#{node['metricbeat']['version']}-windows" + '/install-service-metricbeat.ps1') }
end

powershell_script 'install metricbeat as service' do
  code "#{node['metricbeat']['windows']['base_dir']}/metricbeat-#{node['metricbeat']['version']}-windows/install-service-metricbeat.ps1"
end
