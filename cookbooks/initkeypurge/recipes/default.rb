#
# Cookbook Name:: initkeypurge
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
file "/etc/chef/validation.pem" do 
	action :delete
	backup false
end