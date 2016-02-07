# Chef recipe to perform the initial config of a raspberry pi.
# If you need to rerun this, remove the file named configured
# from /var/lock

# install packages
base_packages = "#{node['package_set']}"
package "install_set" do
  package_name [base_packages]
  action :upgrade
end

# Set up configurations for vi,bash,etc
# Since we want a unified interface we will move in common config files for the users and root
user 'tquinn' do
  comment 'default user account'
  uid '1000'
  gid "tquinn"
  home '/home/tquinn'
  shell '/bin/bash'
  manage_home true
  action :create
end

cookbook_file "/home/tquinn/.vimrc" do
  source 'vimrc'
  owner "tquinn"
  group "tquinn"
  mode "0755"
  action :create
end
cookbook_file "/home/tquinn/.bashrc" do
  source 'bashrc'
  owner "tquinn"
  group "tquinn"
  mode "0755"
  action :create
end
cookbook_file "/home/tquinn/.gitconfig" do
  source 'gitconfig'
  owner "tquinn"
  group "tquinn"
  mode "0755"
  action :create
end
