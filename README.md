# RDS Aurora Learning with Terraform

Terraform project supporting the provisioning of aws infrastructure for RDS aurora with custom VPC and EC2 bastion to access the database.

### Prerequisites

Complete the following manual steps before provisioning:

- Install terraform
- Setup an aws profile
- Set `terraform.tfvars`
- Create a new Key Pair with the same name set to `ssh_key_pair_name` in `terraform.tfvars`

Create the following SSM parameters:

- /rds-learning/database-name - RDS database name
- /rds-learning/database-username (encrypted) - master username for access to RDS
- /rds-learning/database-password (encrypted) - master password for access to RDS
- /rds-learning/ssh-private-key (encrypted) - the contents of your SSH private key

### Provisioning infrastructure

Run `terraform init` to install the modules and then run `terraform apply` to provision the infrastructure on AWS.
