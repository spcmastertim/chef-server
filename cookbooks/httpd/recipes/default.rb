# Default recipe to get apache installed.
# Comment out the below recipe if you are calling this as a dependancy.
httpd_service 'default' do
  action [:create, :start]
end

httpd_config 'default' do
  source 'mysite.cnf.erb'
  notifies :restart, 'httpd_service[default]'
  action :create
end
