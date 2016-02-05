# Chef recipe to perform the initial config of a raspberry pi.
# If you need to rerun this, remove the file named configured
# from /var/lock

# lock file test/create
if File.exists?(/var/lock/configured) then
  exit
else file '/var/lock/configured' do
  content 'Do not remove unless you need to rerun the base configuration'
  mode '0744'
  owner 'root'
  group 'root'
end

# install packages
base_packages = "#{node['packages']}"
package "install_set" do
  package_name [base_packages]
  action :install
end

# upgrade system
