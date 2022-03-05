terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 4.2.0"
    }
  }
  required_version = "~> 1.1.7"
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../../vpc"
  tags   = var.tags
  vpc    = var.vpc_config
}
