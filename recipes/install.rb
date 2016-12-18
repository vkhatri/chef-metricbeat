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

node['metricbeat']['packages'].each do |p|
  package p
end

version_string = node['platform_family'] == 'rhel' ? "#{node['metricbeat']['version']}-#{node['metricbeat']['release']}" : node['metricbeat']['version']

case node['platform_family']
when 'debian'
  # apt repository configuration
  apt_repository 'beats' do
    uri node['metricbeat']['apt']['uri']
    components node['metricbeat']['apt']['components']
    key node['metricbeat']['apt']['key']
    action node['metricbeat']['apt']['action']
    distribution ''
  end

  apt_preference 'metricbeat' do
    pin          "version #{node['metricbeat']['version']}"
    pin_priority '700'
  end

when 'rhel'
  # yum repository configuration
  yum_repository 'beats' do
    description node['metricbeat']['yum']['description']
    baseurl node['metricbeat']['yum']['baseurl']
    gpgcheck node['metricbeat']['yum']['gpgcheck']
    gpgkey node['metricbeat']['yum']['gpgkey']
    enabled node['metricbeat']['yum']['enabled']
    action node['metricbeat']['yum']['action']
  end

  yum_version_lock 'metricbeat' do
    version node['metricbeat']['version']
    release node['metricbeat']['release']
    action :update
  end
end

package 'metricbeat' do # ~FC009
  version version_string
  options node['platform_family'] == 'rhel' ? '' : '-o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"'
  flush_cache(:before => true) if node['platform_family'] == 'rhel'
  allow_downgrade true if node['platform_family'] == 'rhel'
  notifies :restart, 'service[metricbeat]' if node['metricbeat']['notify_restart'] && !node['metricbeat']['disable_service']
end
