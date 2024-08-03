terraform {
  backend "s3" {
    bucket  = "s-one-terraform-prod"
    key     = "aws/main.tfstate"
    region  = "us-east-1"
    encrypt = true
    profile = "default"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region  = var.my_region
  profile = var.my_profile
  default_tags {
    tags = {
      By      = "Terraform"
      Project = "s_one"
    }
  }
}

## Deploy Network Infrastructure for an environment
module "dev_infrastructure" {
  source      = "./my_modules/infrastructure"
  environment = var.environment
  vpc_cidr    = var.vpc_cidr
  az_numbers = 2
}

## Deploy a security components like a security groups and ssh keys
module "dev_security" {
  source = "./my_modules/security"
  environment = var.environment
  my_vpc_id = module.dev_infrastructure.vpc_id
  ssh_pub_path = var.ssh_public_key_path
}

## Deploy a security components like a security groups and ssh keys
module "dev_ec2" {
  source = "./my_modules/ec2"
  environment = var.environment
  public_subnet_ids = module.dev_infrastructure.public_subnet_ids
  security_group_id = module.dev_security.security_group_id
}