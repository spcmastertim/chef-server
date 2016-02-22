#
# Cookbook Name:: mad13
# Recipe:: default
#
# Copyright 2016, Mad 13 Enterprises
#
# All rights reserved - Do Not Redistribute under penalty of slow death
#
# direct all questions to admin@mad13ent.com

# Lets start with the packages to install.
default_load = node['prereqs']['package_install']

package [default_load] do
  action :upgrade
end

# Set the opt directory to allow www-data to write to it
directory '/opt' do
  user 'www-data'
  owner 'www-data'
  mode '0776'
  action :create
end

# test for the presence of the wordpress tarball before uploading
cookbook_file 'wordpress' do
  source "wordpress-#{node['wordpress_info']['version']}.tar.gz"
  owner 'www-data'
  group 'www-data'
  path node['wordpress_info']['install_dir'].to_s
  not_if { ::File.exist?("/opt/wordpress-#{node['wordpress_info']['verion']}.tar.gz") }
end

# Use the tar provider to handle the tarball.  This is not a built in resource
# but rather a 'knife cookbook site install tar' command
tar_extract 'wpcurrent' do
  target_dir '/opt/'
  creates '/opt/wordpress'
  user 'www-data'
  group 'www-data'
  tar_flags node['wordpress_info']['tar_opts'].to_s
  source "/opt/wordpress-#{node['wordpress_info']['install_dir']}wordpress-#{['wordpress_info']['version']}.tar.gz"
  action :extract_local
end

# Here is where we need to build the template for nginx
