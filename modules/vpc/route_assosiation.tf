resource "aws_route_table_association" "public-subnet-assos" {
  count            = length(var.public_subnet_cidr)
  subnet_id        = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id   = aws_route_table.terraform_public.id

}

resource "aws_route_table_association" "private-subnet-assos" {
  count            = length(var.private_subnet_cidr)
  subnet_id        = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id   = aws_route_table.terraform_private.id

}

