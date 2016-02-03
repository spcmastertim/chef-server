# See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "tquinn"
client_key               "#{current_dir}/tquinn.pem"
validation_client_name   "quinncloud-validator"
validation_key           "#{current_dir}/quinncloud-validator.pem"
chef_server_url          "https://chef-server.attlocal.net/organizations/quinncloud"
cookbook_path            ["#{current_dir}/../cookbooks"]
