/*
  This module creates VPC.
*/
variable "tags" {
  type = map(string)
}

variable "vpc" {
  description = "VPC Configuration details"
  type = object({
    cidr_block                       = string
    instance_tenancy                 = string
    map_public_ip_on_launch          = bool
    enable_dns_support               = bool
    enable_dns_hostnames             = bool
    assign_generated_ipv6_cidr_block = bool
    public_subnets_details           = map(map(string))
    private_subnets_details          = map(map(string))
  })
}


locals {
  vpc_default = {
    cidr_block                       = "192.168.0.0/16"
    instance_tenancy                 = "default"
    map_public_ip_on_launch          = true
    enable_dns_support               = true
    enable_dns_hostnames             = true
    assign_generated_ipv6_cidr_block = false
    public_subnets_details = {
      public_subnet_aza = {
        availability_zone = "us-east-1a",
        cidr_block        = "192.168.0.0/26"
        subnet_type       = "public"
      },
      public_subnet_azb = {
        availability_zone = "us-east-1b",
        cidr_block        = "192.168.0.64/26"
        subnet_type       = "public"
      }
    },
    private_subnets_details = {
      private_subnet_aza = {
        availability_zone = "us-east-1a",
        cidr_block        = "192.168.0.128/26"
        subnet_type       = "private"
      },
      private_subnet_azb = {
        availability_zone = "us-east-1b",
        cidr_block        = "192.168.0.192/26"
        subnet_type       = "private"
      }
    }
  }

  vpc = merge(
    local.vpc_default,
    var.vpc
  )
}

