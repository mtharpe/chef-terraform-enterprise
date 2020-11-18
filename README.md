[![pipeline status](https://gitlab.com/chef-recipes/terraform_enterprise/badges/master/pipeline.svg)](https://gitlab.com/chef-recipes/terraform_enterprise/-/commits/master)

# Description

Installs/Configures terraform_enterprise

# Requirements

This is a licensed product from HashiCorp that will require a valid license file. This recipe requires the edit of the `license_file_location` attribute to be set for the path, and the file should be called `license.rli`, located in the recipe under the `files/default` directory.

## Chef Client:

* chef (>= 14.0) ()

## Platform:

* ubuntu (< 16.0)

## Cookbooks:

*No dependencies defined*

# Attributes

* `node['terraform_enterprise']['hostname']` -  Defaults to `node['fqdn']`.
* `node['terraform_enterprise']['install_type']` -  Defaults to `poc`.
* `node['terraform_enterprise']['license_file_location']` -  Defaults to `/tmp`.

# Recipes

* terraform_enterprise::default

# License and Maintainer

Maintainer:: HashiCorp (<hello@hashicorp.com>)

Source:: https://github.com/mtharpe/chef-terraform-enterprise

Issues:: https://github.com/mtharpe/chef-terraform-enterprise/issues

License:: Apache-2.0
