#
# Cookbook Name:: sshd-conf
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/ssh/sshd_config" do 
	source "sshd_config.erb"
	owner "root"
	group "root"
	mode "0400"
	notifies :restart, "service[sshd]"
end

service "sshd" do 
	action :nothing
end