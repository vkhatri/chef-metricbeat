metricbeat Cookbook
================

[![Cookbook](http://img.shields.io/badge/cookbook-v0.2.0-green.svg)](https://github.com/vkhatri/chef-metricbeat)[![Build Status](https://travis-ci.org/vkhatri/chef-metricbeat.svg?branch=master)](https://travis-ci.org/vkhatri/chef-metricbeat)

This is a [Chef] cookbook to manage [metricbeat].


>> For Production environment, always prefer the [most recent release](https://supermarket.chef.io/cookbooks/metricbeat).


## Most Recent Release

```
cookbook 'metricbeat', '~> 0.2.0'
```

## From Git

```
cookbook 'metricbeat', github: 'vkhatri/chef-metricbeat'
```

## Repository

https://github.com/vkhatri/chef-metricbeat


## Supported OS

This cookbook was tested on Amazon & Ubuntu Linux and expected to work on other RHEL platforms and Windows.


## Recipes

- `metricbeat::default` - default recipe (use it for run_list)

- `metricbeat::install` - install metricbeat for rhel, debian, ubuntu based OS

- `metricbeat::config` - configure metricbeat

- `metricbeat::install_windows` - configure metricbeat for windows based OS


## Core Attributes


* `default['metricbeat']['version']` (default: `5.1.1`): metricbeat version

* `default['metricbeat']['release']` (default: `1`): metricbeat release for yum package

* `default['metricbeat']['packages']` (default: `[]`): package dependencies

* `default['metricbeat']['conf_dir']` (default: `/etc/metricbeat` or `C:/opt/metricbeat/metricbeat-1.3.1-windows/`): metricbeat yaml configuration file directory

* `default['metricbeat']['conf_file']` (default: `/etc/metricbeat/metricbeat.yml` or `C:/opt/metricbeat/metricbeat-1.3.1-windows/metricbeat.yml`): metricbeat configuration file

* `default['metricbeat']['notify_restart']` (default: `true`): whether to restart metricbeat service on configuration file change

* `default['metricbeat']['disable_service']` (default: `false`): whether to stop and disable metricbeat service, useful for maintenance mode


## Configuration File metricbeat.yml Attributes

* `default['metricbeat']['config']['input']['period']` (default: `10`): metricbeat statistics collection interval

* `default['metricbeat']['config']['input']['period']` (default: `10`): metricbeat procs to collect statistics

* `default['metricbeat']['config']['output']` (default: `{}`): metricbeat output configuration, e.g. elasticsearch, logstash, file etc.

For more attribute info, visit below link:

https://github.com/elastic/metricbeat/blob/master/etc/metricbeat.yml


## metricbeat YUM/APT Repository Attributes

* `default['metricbeat']['yum']['description']` (default: ``): beats yum reporitory attribute

* `default['metricbeat']['yum']['gpgcheck']` (default: `true`): beats yum reporitory attribute

* `default['metricbeat']['yum']['enabled']` (default: `true`): beats yum reporitory attribute

* `default['metricbeat']['yum']['baseurl']` (default: `https://packages.elastic.co/beats/yum/el/$basearch`): beatsyum reporitory attribute

* `default['metricbeat']['yum']['gpgkey']` (default: `https://packages.elasticsearch.org/GPG-KEY-elasticsearch`): beats yum reporitory attribute

* `default['metricbeat']['yum']['action']` (default: `:create`): beats yum reporitory attribute


* `default['metricbeat']['apt']['description']` (default: `calculated`): beats apt reporitory attribute

* `default['metricbeat']['apt']['components']` (default: `['stable', 'main']`): beats apt reporitory attribute

* `default['metricbeat']['apt']['uri']` (default: `https://packages.elastic.co/beats/apt`): beats apt reporitory attribute

* `default['metricbeat']['apt']['key']` (default: `http://packages.elasticsearch.org/GPG-KEY-elasticsearch`): beats apt reporitory attribute

* `default['metricbeat']['apt']['action']` (default: `:add`): filebeat apt reporitory attribute


## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests (`rake & rake knife`), ensuring they all pass
6. Write new resource/attribute description to `README.md`
7. Write description about changes to PR
8. Submit a Pull Request using Github


## Copyright & License

Authors:: Virender Khatri and [Contributors]

<pre>
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
</pre>


[Chef]: https://www.chef.io/
[metricbeat]: https://www.elastic.co/downloads/beats/metricbeat
[Contributors]: https://github.com/vkhatri/chef-metricbeat/graphs/contributors
