resource "aws_vpc" "main" {
  cidr_block = var.vpc_config.cidr_block

  tags = {
    Name = var.vpc_config.name
  }

}

resource "aws_subnet" "main" {
  vpc_id   = aws_vpc.main.id
  for_each = var.subnet_config

  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    Name = "${var.vpc_config.name}-subnet-${each.key}"
  }
}

locals {
  #subnet_key = {} if public is true in subnet_config else null
  public_subnet = {
    for subnet_key, subnet in var.subnet_config : subnet_key => subnet
    if subnet.public == true
  }

  private_subnet = {
    for subnet_key, subnet in var.subnet_config : subnet_key => subnet
    if subnet.public == false || subnet.public == null
  }
}

#Internet gateway, if public is true in subnet_config then only create IGW and route table association
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  count  = length(local.public_subnet) > 0 ? 1 : 0

  tags = {
    Name = "${var.vpc_config.name}-igw"
  }
}

#Route table, if public is true in subnet_config then only create route table and route table association
resource "aws_route_table" "main" {
  count  = length(local.public_subnet) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main[0].id
  }
}

resource "aws_route_table_association" "main" {
  for_each       = local.public_subnet
  subnet_id      = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.main[0].id
}
