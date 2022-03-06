<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 4.2.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | git@github.com:VijayBheemineni/terraform_modules_aws_vpc.git | v0.1.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | <pre>{<br>  "description": "Test VPC",<br>  "name": "vpc_poc",<br>  "terraform_version": "1.1.7"<br>}</pre> | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | n/a | `map` | <pre>{<br>  "assign_generated_ipv6_cidr_block": false,<br>  "cidr_block": "192.168.1.0/24",<br>  "enable_dns_hostnames": true,<br>  "enable_dns_support": true,<br>  "instance_tenancy": "default",<br>  "map_public_ip_on_launch": true,<br>  "private_subnets_details": {<br>    "private_subnet_aza": {<br>      "availability_zone": "us-east-1a",<br>      "cidr_block": "192.168.1.128/26",<br>      "subnet_type": "private"<br>    },<br>    "private_subnet_azb": {<br>      "availability_zone": "us-east-1b",<br>      "cidr_block": "192.168.1.192/26",<br>      "subnet_type": "private"<br>    }<br>  },<br>  "public_subnets_details": {<br>    "public_subnet_aza": {<br>      "availability_zone": "us-east-1a",<br>      "cidr_block": "192.168.1.0/26",<br>      "subnet_type": "public"<br>    },<br>    "public_subnet_azb": {<br>      "availability_zone": "us-east-1b",<br>      "cidr_block": "192.168.1.64/26",<br>      "subnet_type": "public"<br>    }<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_igw_id"></a> [igw\_id](#output\_igw\_id) | n/a |
| <a name="output_nat_gws_id"></a> [nat\_gws\_id](#output\_nat\_gws\_id) | n/a |
| <a name="output_private_subnets_id"></a> [private\_subnets\_id](#output\_private\_subnets\_id) | n/a |
| <a name="output_public_subnets_id"></a> [public\_subnets\_id](#output\_public\_subnets\_id) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END_TF_DOCS -->