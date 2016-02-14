require 'serverspec'

# Required by serverspec
set :backend, :exec

describe command('ls -al /tmp/cases/*-incidentreport/*-sysdig.scap') do
  its(:stdout) { should match /sysdig/ }
## FIXME! undefined method `size' for #<Serverspec::Type::Command:0x00000002c09b38>
#  its(:size) { should > 0 }
end


