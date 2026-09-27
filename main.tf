################################################################################
# Provider e backend
################################################################################

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.9"
    }
  }

  backend "s3" {
    bucket  = "projetodevopstf"
    key     = "deployweb.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  tags = {
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}

################################################################################
# Modulos locais: cada pasta encapsula um modulo oficial do Terraform Registry
# vpc/            -> terraform-aws-modules/vpc/aws
# security_group/ -> terraform-aws-modules/security-group/aws
# ec2/            -> terraform-aws-modules/ec2-instance/aws
################################################################################

module "vpc" {
  source = "./vpc"

  name           = "${var.project_name}-vpc"
  cidr           = var.vpc_cidr
  azs            = var.availability_zones
  public_subnets = var.public_subnets
  tags           = local.tags
}

module "security_group" {
  source = "./security_group"

  name                = "${var.project_name}-sg"
  description         = "Allow HTTP, HTTPS and SSH inbound traffic"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = var.allowed_ingress_cidr_blocks
  tags                = local.tags
}

module "ec2" {
  source = "./ec2"

  name              = "${var.project_name}-web"
  ami               = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  subnet_id         = module.vpc.public_subnets[0]
  security_group_id = module.security_group.security_group_id
  user_data         = file("${path.module}/script.sh")
  tags              = local.tags
}
