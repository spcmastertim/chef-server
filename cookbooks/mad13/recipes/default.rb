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
system_type = node['platform_family']
# There was some logic to modify the packages based on platform_family
# but since the pi's are raspbian it seems silly to make my site portable

package [default_load] do
  action :upgrade
end
