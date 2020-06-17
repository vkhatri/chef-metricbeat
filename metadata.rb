name 'metricbeat'
maintainer 'Virender Khatri'
maintainer_email 'vir.khatri@gmail.com'
license 'Apache-2.0'
description 'Installs/Configures Elastic metricbeat'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.2.4'

chef_version '>= 12' if respond_to?(:chef_version)

source_url 'https://github.com/vkhatri/chef-metricbeat' if respond_to?(:source_url)
issues_url 'https://github.com/vkhatri/chef-metricbeat/issues' if respond_to?(:issues_url)

depends 'yum'
depends 'apt'
depends 'windows'
depends 'yum-plugin-versionlock'

%w[ubuntu centos amazon redhat fedora windows].each do |os|
  supports os
end
