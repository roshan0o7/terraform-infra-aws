module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
}

module "bastion" {
  source         = "./modules/bastion"
  vpc_id         = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "private_server" {
  source              = "./modules/private_server"
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  bastion_security_group_id = module.bastion.bastion_sg_id
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  private_server_ids = [module.private_server.private_server_id]
  security_group_id = module.private_server.private_sg_id
}

module "rds" {
  source             = "./modules/rds"
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  availability_zone  = element(var.availability_zones, 0)  # or specify a specific AZ
}

module "iam" {
  source = "./modules/iam"
}