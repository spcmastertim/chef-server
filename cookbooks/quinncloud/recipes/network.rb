# Quinncloud cookbook network setup
# Set up interface to go online at boot

ifconfig eth0 do
  device 'eth0'
  onboot true
  retries '3'
  bootproto 'dhcp'
end

cookbook_file '/etc/hosts' do
  source 'hosts'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
