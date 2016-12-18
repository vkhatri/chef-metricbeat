#
# Cookbook Name:: metricbeat
# Recipe:: config
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

file node['metricbeat']['conf_file'] do
  content JSON.parse(node['metricbeat']['config'].to_json).to_yaml.lines.to_a[1..-1].join
  notifies :restart, 'service[metricbeat]' if node['metricbeat']['notify_restart'] && !node['metricbeat']['disable_service']
end

service_action = node['metricbeat']['disable_service'] ? [:disable, :stop] : [:enable, :start]

ruby_block 'delay metricbeat service start' do
  block do
  end
  notifies :start, 'service[metricbeat]'
  not_if { node['metricbeat']['disable_service'] }
end

service 'metricbeat' do
  supports :status => true, :restart => true
  action service_action
end
