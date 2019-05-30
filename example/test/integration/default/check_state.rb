describe command('terraform output client_vpn_endpoint') do
  its('stdout') { should include  'cvpn-endpoint-' }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 0 }
end

describe command('terraform output client_vpn_network_association') do
  its('stdout') { should eq  "associated\n" }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 0 }
end

