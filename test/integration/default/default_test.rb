# InSpec test for recipe terraform_enterprise::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

require 'rspec/retry'

describe directory('/etc/terraform.d') do
  it { should exist }
end

describe file('/etc/terraform.d/settings.json') do
  it { should exist }
end

describe directory('/var/lib/replicated') do
  it { should exist }
end

describe 'ping_website' do
  let(:resource) { command('curl -vk localhost:8800') }
  it 'should exit with exit code 0', retry: 100, retry_wait: 100 do
    expect(resource.exit_status).to eq 0
  end
end

describe 'docker_status' do
  let(:resource) { command('/usr/local/bin/replicatedctl app status |grep started') }
  it 'should exit with exit code 0', retry: 100, retry_wait: 100 do
    expect(resource.exit_status).to eq 0
  end
end

describe json(command: '/usr/local/bin/replicatedctl app status') do
  its([0, 'State']) { should eq 'started' }
  its([0, 'DesiredState']) { should eq 'started' }
  its([0, 'IsTransitioning']) { should eq false }
end

%w(ptfe_atlas ptfe_registry_api ptfe_sidekiq ptfe_state_parser ptfe_build_manager
   ptfe_registry_worker ptfe_ingress ptfe_redis ptfe_nomad ptfe_postgres ptfe_archivist
   ptfe_vault replicated).each do |container|
  describe command('docker ps') do
    its('stdout') { should include container }
  end
end
