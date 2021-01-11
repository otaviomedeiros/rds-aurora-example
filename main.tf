provider "aws" {
  profile = var.profile
  region  = var.region
}

module "vpc" {
  source = "./modules/vpc"

  cidr_block         = var.main_vpc_cidr_block
  availability_zones = var.availability_zones
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id = module.vpc.vpc_id
}

module "rds" {
  source = "./modules/rds"

  instances_count      = 1
  availability_zones   = var.availability_zones
  db_security_group_id = module.security_groups.db_security_group_id
  private_subnet_ids   = module.vpc.private_subnet_ids
}

module "ec2" {
  source = "./modules/ec2"

  availability_zones        = var.availability_zones
  public_subnet_ids         = module.vpc.public_subnet_ids
  ssh_key_pair_name         = var.ssh_key_pair_name
  bastion_security_group_id = module.security_groups.bastion_security_group_id
}
