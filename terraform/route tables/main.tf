resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.name
  }
}

# Associate route table with subnets
resource "aws_route_table_association" "subnet_association" {
  for_each    = toset(var.subnet_ids)
  subnet_id   = each.value
  route_table_id = aws_route_table.route_table.id
}

# Optional route to internet gateway (only for public)
resource "aws_route" "igw_route" {
  count = var.create_internet_gateway_route ? 1 : 0

  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}
