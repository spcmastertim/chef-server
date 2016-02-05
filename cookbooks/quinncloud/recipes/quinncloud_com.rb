# Creating default webpage for quinncloud.com
# quinncloud_com recipe
# Tim Quinn - mstrtimespace@gmail.com

# Install http
httpd_service 'default' do
  action [:create, :start]
end

httpd_config 'default' do
  source 'mysite.cnf.erb'
  notifies :restart, 'httpd_service[default]'
  action :create
end
