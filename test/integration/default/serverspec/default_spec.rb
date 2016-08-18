require 'serverspec'
set :backend, :exec

describe service('nomad') do
  it { should be_enabled }
  it { should be_running }
end

describe process('nomad') do
  its(:count) { should eq 1 }
  its(:user) { should eq 'nomad' }
  its(:group) { should eq 'nomad' }
  its(:args) { should match '-config /etc/nomad.json' }
  it { should be_running }
end

describe user('nomad') do
  it { should exist }
end

describe file('/etc/nomad.json') do
  it { should be_file }
  it { should be_owned_by 'nomad' }
  it { should be_grouped_into 'nomad' }
end

describe file('/opt/nomad/0.4.1/nomad') do
  it { should be_file }
  it { should be_executable }
end
