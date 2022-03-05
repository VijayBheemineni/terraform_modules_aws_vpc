resource "aws_vpc" "main" {
  cidr_block                       = local.vpc.cidr_block
  instance_tenancy                 = local.vpc.instance_tenancy
  enable_dns_support               = local.vpc.enable_dns_support
  enable_dns_hostnames             = local.vpc.enable_dns_hostnames
  assign_generated_ipv6_cidr_block = local.vpc.assign_generated_ipv6_cidr_block
  tags = merge(
    {
      Name = var.tags.name
    },
    var.tags
  )
}

resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.main.id
  for_each                = local.vpc.public_subnets_details
  availability_zone       = each.value.availability_zone
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = local.vpc.map_public_ip_on_launch
  tags = merge(
    {
      Name        = join("_", [var.tags.name, each.key]),
      subnet_type = each.value.subnet_type
    },
    var.tags
  )
  depends_on = [
    aws_vpc.main
  ]
}

resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.main.id
  for_each          = local.vpc.private_subnets_details
  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block
  tags = merge(
    {
      Name        = join("_", [var.tags.name, each.key]),
      subnet_type = each.value.subnet_type
    },
    var.tags
  )
  depends_on = [
    aws_vpc.main
  ]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      Name = var.tags.name
    },
    var.tags
  )
}

resource "aws_eip" "nat_gw_public_ip" {
  vpc      = true
  for_each = local.vpc.public_subnets_details
  tags = merge(
    {
      Name = join("_", [var.tags.name, each.key])
    },
    var.tags
  )
  depends_on = [
    aws_subnet.private_subnets
  ]
}

resource "aws_nat_gateway" "nat_gw" {
  for_each      = aws_eip.nat_gw_public_ip
  allocation_id = each.value.id
  subnet_id     = aws_subnet.public_subnets[each.key].id

  tags = merge(
    {
      Name = join("_", [var.tags.name, each.key])
    },
    var.tags
  )

  depends_on = [
    aws_internet_gateway.igw,
    aws_eip.nat_gw_public_ip
  ]
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      Name = join("_", [var.tags.name, "public"])
    },
    var.tags
  )
}

resource "aws_route_table" "private_rt" {
  for_each = aws_subnet.private_subnets
  vpc_id   = aws_vpc.main.id
  tags = merge(
    {
      Name = join("_", [var.tags.name, each.key])
    },
    var.tags
  )
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "private_nat_gateway" {
  count                  = length(values(aws_route_table.private_rt))
  route_table_id         = values(aws_route_table.private_rt)[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = values(aws_nat_gateway.nat_gw)[count.index].id
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_route_table_association" "private" {
  for_each       = aws_subnet.private_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rt[each.key].id
}

