# Chef recipe to perform the initial config of a raspberry pi.
# If you need to rerun this, remove the file named configured
# from /var/lock

# install packages
base_packages = "#{node['install_adds']['package_set']}"
package 'install_set' do
  package_name [base_packages]
  not_if base_packages = nil
  action :upgrade
end

# Set up configurations for vi,bash,etc
# Since we want a unified interface we will move in common config
# files for the users and root
user 'tquinn' do
  comment 'default user account'
  uid '1000'
  gid 'tquinn'
  home '/home/tquinn'
  shell '/bin/bash'
  manage_home true
  action :create
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
  action :create
end

# Here is the conundrum, do I use a bash block or build a lwrp?  I
# Will drop a bash block to get it working but this is really a crap
# solution and i know it...  tq 2/15/16

bash 'extract_build_ruby' do
  cwd ::File.dirname('/opt/ruby/')
  code <<-EOH
    tar xzf ruby-2.3.0.tar.gz
    cd ruby-2.3.0
    ./configure --enable-shared
    make all
    make test
    if [$? -ne 0]
      then
        make install
      else
        echo 'trying to make sure the directory is right and trying one more time'
        cd /opt/ruby/ruby-2.3.0
        ./configure --enable-shared
        make all
        make test
        if [?! -ne 0]
          then
            echo 'giving up, tests broken'
            exit 20
          else echo 'fix your directory structure!'
        fi
    fi
    echo 'Ruby 2.3.0 installed'
    EOH
  user 'root'
  group 'root'
  action :run
end

# Now we have sqlite, ruby 2.3.0, and ruby installed.  Oh snap - gemfile!
# So fuck a bunch of that noise, lets just install rails and go from there..

gem_package 'rails' do
  action :install
end
