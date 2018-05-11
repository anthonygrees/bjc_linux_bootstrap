#
# Cookbook:: bjc_linux_bootstrap
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
bash 'extract_module' do
    code <<-EOH

#!/bin/bash -xev

# Do some chef pre-work
/bin/mkdir -p /etc/chef
/bin/mkdir -p /var/lib/chef
/bin/mkdir -p /var/log/chef

# Setup hosts file correctly
cat > "/etc/hosts" << EOF
34.216.239.205 chef.automate-demo.com
34.211.141.147 automate.automate-demo.com
EOF

cd /etc/chef/

# Install chef
curl -L https://omnitruck.chef.io/install.sh | bash || error_exit 'could not install chef'

# Create first-boot.json
cat > "/etc/chef/first-boot.json" << EOF
{
   "run_list" :[
   "role[base]"
   ]
}
EOF

NODE_NAME=node-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 4 | head -n 1)

# Create client.rb
/bin/echo 'log_location     STDOUT' >> /etc/chef/client.rb
/bin/echo -e "chef_server_url  \"https://chef.automate-demo.com/organizations/automate\"" >> /etc/chef/client.rb
/bin/echo -e "validation_client_name \"automate-validator\"" >> /etc/chef/client.rb
/bin/echo -e "validation_key \"/etc/chef/validator.pem\"" >> /etc/chef/client.rb
/bin/echo -e "node_name  \"${NODE_NAME}\"" >> /etc/chef/client.rb

sudo chef-client -j /etc/chef/first-boot.json

EOH
end