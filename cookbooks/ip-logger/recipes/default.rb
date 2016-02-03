#
# Cookbook Name:: ip-logger
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
search("node","ipaddress:10.*").each do |server|
	log "The servers in your organization have the following FQDN/IP Addresses:- #{server['fqdn']}/#{server['ipaddress']}"
end