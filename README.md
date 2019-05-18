# bjc_linux_bootstrap

## Description
This cookbook uses kitchen to stand up a CentOS Linux instance in AWS for a student to use in the Chef InSpec Compliance Training

## Recipes

### default.rb
Bootstraps the instance to the Chef Server and Chef Automate.  It is currently locked to Chef 14.

### run_client.rb
Runs the Chef Client on the Linux Node to take the latest cookbooks off the Chef Server

## Requirements
There are 4 items that need to be updated before the Cookbook can run.

### 1. default.rb
Update the IP address for the Chef Server

```bash
xxx.xxx.xxx.xxx chef.automate-demo.com
xxx.xxx.xxx.xxx automate.automate-demo.com
```

### 2. .kitchen.yml
Update the AWS SG and Subnet

```bash
  security_group_ids: sg-99x999x99
  subnet_id: subnet-9x999999
```

### 3. validator.pem
Log on to the Chef Server in the BJC and reset the ORG validator and update the file under recipes.
