require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package('sysdig') do
  it { should be_installed }
end

describe file('/usr/bin/sysdig') do
  it { should be_executable }
end

#describe command('ls -al /tmp/cases/*-incidentreport/*-sysdig.scap') do
#  its(:stdout) { should match /sysdig/ }
### FIXME! undefined method `size' for #<Serverspec::Type::Command:0x00000002c09b38>
##  its(:size) { should > 0 }
#end


