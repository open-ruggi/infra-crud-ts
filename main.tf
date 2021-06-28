module "networking" {
  source           = "./modules/vpc"
  cidr_block       = "10.0.0.0/16"
  environment_name = "codeChallenge"
  public_subnet = "10.0.0.0/24"
  private_subnet = "10.0.1.0/24"
}

module "ssh-key" {
  source    = "./modules/key"
  environment = "codeChallenge"
}

module "instance" {
  source     = "./modules/instance"
  environment  = "codeChallenge"
  vpc_id = module.networking.vpc_id
  public_subnets= module.networking.aws_subnet_public
  private_subnets= module.networking.aws_subnet_private
  key_name   = module.ssh-key.key_name
}