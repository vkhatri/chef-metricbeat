default['metricbeat']['version'] = '5.1.1'
default['metricbeat']['release'] = '1'
default['metricbeat']['disable_service'] = false
default['metricbeat']['package_url'] = 'auto'
default['metricbeat']['packages'] = []
default['metricbeat']['notify_restart'] = true
default['metricbeat']['windows']['base_dir'] = 'C:/opt/metricbeat'
default['metricbeat']['conf_dir'] = if node['platform'] == 'windows'
                                      "#{node['metricbeat']['windows']['base_dir']}/metricbeat-#{node['metricbeat']['version']}-windows"
                                    else
                                      '/etc/metricbeat'
                                    end
default['metricbeat']['conf_file'] = if node['platform'] == 'windows'
                                       "#{node['metricbeat']['conf_dir']}/metricbeat.yml"
                                     else
                                       ::File.join(node['metricbeat']['conf_dir'], 'metricbeat.yml')
                                     end

default['metricbeat']['yum']['description'] = 'Elastic Beats Repository'
default['metricbeat']['yum']['gpgcheck'] = true
default['metricbeat']['yum']['enabled'] = true
default['metricbeat']['yum']['gpgkey'] = 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
default['metricbeat']['yum']['action'] = :create

default['metricbeat']['apt']['description'] = 'Elastic Beats Repository'
default['metricbeat']['apt']['components'] = %w(stable main)
default['metricbeat']['apt']['key'] = 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
default['metricbeat']['apt']['action'] = :add
