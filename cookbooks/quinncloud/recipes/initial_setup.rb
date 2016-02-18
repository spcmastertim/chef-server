# Chef recipe to perform the initial config of a raspberry pi.
# If you need to rerun this, remove the file named configured
# from /var/lock

# install packages
#install_me = node['install_adds']['package_set']
#install_me.each do |installset|
#  package 'installset' do
#    package_name installset
#    action :upgrade
#  end
#end

# Set up configurations for vi,bash,etc
# Since we want a unified interface we will move in common config
# files for the users and root
%w( admin tquinn ).each do |group|
  users_manage group do
    action :create
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
end

# Upload the ruby tarball to the client
cookbook_file '/opt/ruby/ruby-2.3.0.tar.gz' do
  source 'ruby-2.3.0.tar.gz'
  owner 'tquinn'
  group 'tquinn'
  mode '0644'
  only_if { ::File.exist?('/opt/ruby/ruby-2.3.0.tar.gz') }
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
    make clean
    ./configure --enable-shared
    make all
    make test
    make install
    touch /opt/ruby/installed
    EOH
  user 'root'
  group 'root'
  not_if { ::File.exist?('/opt/ruby/installed') }
  action :run
end

gem_package 'rails' do
  not_if { ::File.exist?('/usr/local/bin/rails') }
  action :install
  ignore_failure true
end

directory '/home/tquinn/.ssh' do
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
  notifies :restart, 'service[ssh]', :delayed
  action :create
end

service 'ssh' do
  action :nothing
end
