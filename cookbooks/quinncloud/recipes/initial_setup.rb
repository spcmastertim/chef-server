# Chef recipe to perform the initial config of a raspberry pi.
# If you need to rerun this, remove the file named configured
# from /var/lock

# install packages
# install_me = node['install_adds']['package_set']
# install_me.each do |installset|
#   package 'installset' do
#     package_name installset
#     action :upgrade
#   end
# end
# Set up dependant recipes
include_recipe 'users::sysadmins'

# Set up configurations for vi,bash,etc
# Since we want a unified interface we will move in common config
# files for the users and root
%w( admin tquinn ).each do |group|
  users_manage group do
    action :create
    data_bag 'users'
  end
end

cookbook_file '/home/tquinn/.vimrc' do
  source 'vimrc'
  owner 'tquinn'
  group 'tquinn'
  mode '0755'
  action :create
end
cookbook_file '/home/tquinn/.bashrc' do
  source 'bashrc'
  owner 'tquinn'
  group 'tquinn'
  mode '0755'
  action :create
end
cookbook_file '/home/tquinn/.gitconfig' do
  source 'gitconfig'
  owner 'tquinn'
  group 'tquinn'
  mode '0755'
  action :create
end

directory '/opt/ruby' do
  owner 'tquinn'
  group 'tquinn'
  mode '775'
  action :create
  not_if { ::File.exist?('/opt/ruby') }
end

# Upload the ruby tarball to the client
cookbook_file '/opt/ruby/ruby-2.3.0.tar.gz' do
  source 'ruby-2.3.0.tar.gz'
  owner 'tquinn'
  group 'tquinn'
  mode '0644'
  not_if { ::File.exist?('/opt/ruby/ruby-2.3.0.tar.gz') }
  action :create
end

# add the /etc/issue so ssh doesn't crap out
cookbook_file '/etc/issue' do
  source 'issue'
  owner 'root'
  group 'root'
  mode '0644'
  not_if { ::File.exist?('/etc/issue') }
  action :create
end

# Here is the conundrum, do I use a bash block or build a lwrp?  I
# Will drop a bash block to get it working but this is really a crap
# solution and i know it...  tq 2/15/16

bash 'extract_build_ruby' do
  cwd ::File.dirname('/opt/ruby/')
  code <<-EOH
    cd /opt/ruby/
    tar xzf ruby-2.3.0.tar.gz
    cd ruby-2.3.0
    make distclean
    ./configure --enable-shared
    make all
    make install
    touch /opt/ruby/ruby-2.3.0/installed
    EOH
  user 'root'
  group 'root'
  not_if { ::File.exist?('/opt/ruby/ruby-2.3.0/installed') }
  action :run
end

gem_package 'rails' do
  not_if { ::File.exist?('/usr/local/bin/rails') }
  action :install
  ignore_failure true
end

# User management, to be moved to a loop
# users_manage 'tquinn' do
#   action [:create]
#   data_bag 'tquinn'
#   manage_nfs_home_dirs false
# end
#
# users_manage 'admin' do
#   action [:create]
#   data_bag 'admin'
#   manage_nfs_home_dirs false
# end
#
# users_manage 'sysadmin' do
#   group_id 2300
#   action [:remove, :create]
# end
#
# users_manage 'chef-users' do
#   group_id 2400
#   action [:remove, :create]
# end

directory '/home/tquinn/.ssh' do
  user 'tquinn'
  group 'tquinn'
  mode '0700'
end

cookbook_file '/home/tquinn/.ssh/authorized_keys' do
  source 'tquinn_authorized_keys'
  user 'tquinn'
  group 'tquinn'
  mode '0600'
end

template '/etc/ssh/sshd_config' do
  source 'sshd_config.erb'
  user 'root'
  group 'root'
  mode '0644'
  if node['platform_family'] == 'debian'
    notifies :restart, 'service[ssh]', :delayed
  elsif node['platform_family'] == 'rhel'
    notifies :restart, 'service[sshd]', :delayed
  end
  action :create
end

service 'ssh' do
  action :nothing
end

service 'sshd' do
  action :nothing
end

# Lets set up the ntp clients and one server which we will
# detertmine by role.

cookbook_file '/etc/ntp.conf' do
  source 'ntp.conf_client'
  mode '0664'
  not_if { node['git_config']['server'] == true }
end

cookbook_file '/etc/ntp.conf' do
  source 'ntp.conf_server'
  mode '0644'
  not_if { node['hostname'] == 'pi1' }
end
