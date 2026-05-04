default['terraform_enterprise']['hostname']              = node['fqdn']
default['terraform_enterprise']['install_type']          = 'poc'
default['terraform_enterprise']['license_file_location'] = '/tmp'
default['terraform_enterprise']['installer_url']         = 'https://install.terraform.io/ptfe/stable'
default['terraform_enterprise']['private_address']       = node['ipaddress']
default['terraform_enterprise']['public_address']        = node['ipaddress']
default['terraform_enterprise']['admin_console_port']    = 8800
default['terraform_enterprise']['post_install_sleep']    = 410
