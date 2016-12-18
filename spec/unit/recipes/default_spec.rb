require 'spec_helper'

describe 'metricbeat::default' do
  shared_examples_for 'metricbeat' do
    context 'all_platforms' do
      %w(install config).each do |r|
        it "include recipe metricbeat::#{r}" do
          expect(chef_run).to include_recipe("metricbeat::#{r}")
        end
      end

      it 'install metricbeat package' do
        expect(chef_run).to install_package('metricbeat')
      end

      it 'configure /etc/metricbeat/metricbeat.yml' do
        expect(chef_run).to create_file('/etc/metricbeat/metricbeat.yml')
      end

      it 'enable metricbeat service' do
        expect(chef_run).to enable_service('metricbeat')
        expect(chef_run).to start_service('metricbeat')
      end
    end
  end

  context 'rhel' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8') do |node|
        node.automatic['platform_family'] = 'rhel'
      end.converge(described_recipe)
    end

    it 'adds beats yum repository' do
      expect(chef_run).to create_yum_repository('beats')
    end

    it 'add yum_version_lock metricbeat' do
      expect(chef_run).to update_yum_version_lock('metricbeat')
    end

    include_examples 'metricbeat'
  end

  context 'ubuntu' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
        node.automatic['platform_family'] = 'debian'
      end.converge(described_recipe)
    end

    it 'adds beats apt repository' do
      expect(chef_run).to add_apt_repository('beats')
    end

    it 'add beats apt version preference' do
      expect(chef_run).to add_apt_preference('metricbeat')
    end

    include_examples 'metricbeat'
  end

  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2012') do |node|
        node.automatic['platform_family'] = 'windows'
      end.converge(described_recipe)
    end

    it 'install metricbeat package' do
      expect(chef_run).to run_powershell_script('install metricbeat as service')
    end

    it 'delay service start' do
      expect(chef_run).to run_ruby_block('delay metricbeat service start')
    end

    it 'download metricbeat from web' do
      expect(chef_run).to create_remote_file('metricbeat_package_file')
    end

    it 'create install directory' do
      expect(chef_run).to create_directory('C:/opt/metricbeat')
    end

    it 'Unpack zip file' do
      expect(chef_run).to unzip_windows_zipfile_to('C:/opt/metricbeat')
    end

    it 'configure C:/opt/metricbeat/metricbeat.yml' do
      expect(chef_run).to create_file('C:/opt/metricbeat/metricbeat-5.1.1-windows/metricbeat.yml')
    end

    it 'enable metricbeat service' do
      expect(chef_run).to enable_service('metricbeat')
      expect(chef_run).to start_service('metricbeat')
    end
  end
end
