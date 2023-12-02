provider "aws" {
  region = "us-east-1"

}

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.9"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "projetodevopstf"
    key = "deployweb.tfstate"
    region = "us-east-1"
    encrypt = true
    }
}

module "vpc" {
  source = "./vpc"
}

module "security_group" {
  source = "./security_group"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "./ec2"
  sec_group_id = module.security_group.sec_group_id
  subnet_id = module.vpc.public_subnet_1a
}
