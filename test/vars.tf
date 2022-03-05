variable "tags" {
  default = {
    name              = "vpc_poc"
    terraform_version = "1.1.7"
    description       = "Test VPC"
  }
}

variable "vpc_config" {
  default = {
    cidr_block                       = "192.168.1.0/24"
    instance_tenancy                 = "default"
    map_public_ip_on_launch          = true
    enable_dns_support               = true
    enable_dns_hostnames             = true
    assign_generated_ipv6_cidr_block = false
    public_subnets_details = {
      public_subnet_aza = {
        availability_zone = "us-east-1a"
        cidr_block        = "192.168.1.0/26"
        subnet_type       = "public"
      },
      public_subnet_azb = {
        availability_zone = "us-east-1b"
        cidr_block        = "192.168.1.64/26"
        subnet_type       = "public"
      }
    },
    private_subnets_details = {
      private_subnet_aza = {
        availability_zone = "us-east-1a"
        cidr_block        = "192.168.1.128/26"
        subnet_type       = "private"
      },
      private_subnet_azb = {
        availability_zone = "us-east-1b"
        cidr_block        = "192.168.1.192/26"
        subnet_type       = "private"
      }
    }
  }
}
