provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./vpc"
}

module "ecs" {
  source    = "./ecs"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.subnet_id
}



output "aws_vpc_id" {
  value = module.vpc.vpc_id
}

output "aws_subnet_id" {
  value = module.vpc.subnet_id
}

output "aws_internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}