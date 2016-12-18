# https://github.com/elastic/metricbeat/blob/master/etc/metricbeat.yml
# https://www.elastic.co/guide/en/beats/metricbeat/current/index.html
#
# capture interface traffic
default['metricbeat']['config']['input']['period'] = 10
default['metricbeat']['config']['input']['procs'] = ['.*']

# default['metricbeat']['config']['shipper']['name'] = node['fqdn'] || node['host']
# default['metricbeat']['config']['shipper']['tags'] = []

default['metricbeat']['config']['output'] = {}
# elasticsearch host info
# default['metricbeat']['config']['output']['elasticsearch']['enabled'] = true
# default['metricbeat']['config']['output']['elasticsearch']['hosts'] = []
#
# default['metricbeat']['config']['output']['redis']['enabled'] = false
# default['metricbeat']['config']['output']['redis']['host'] = '127.0.0.1'
# default['metricbeat']['config']['output']['redis']['port'] = 6_379
#
# default['metricbeat']['config']['output']['file']['enabled'] = false
# default['metricbeat']['config']['output']['file']['path'] = '/tmp/metricbeat'
# default['metricbeat']['config']['output']['file']['filename'] = 'metricbeat'
# default['metricbeat']['config']['output']['file']['rotate_every_kb'] = 1_000
# default['metricbeat']['config']['output']['file']['number_of_files'] = 7
