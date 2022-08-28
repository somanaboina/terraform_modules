resource "aws_subnet" "public_subnets" {
  count               = length(var.public_subnet_cidr)
  vpc_id              = aws_vpc.default.id
  cidr_block          = element(var.public_subnet_cidr, count.index)
  availability_zone   = element(var.azs, count.index)
  tags = { 
    Name = "${var.vpc_name}-publicsubnet-${count.index + 1}"
  }
}
resource "aws_subnet" "private_subnets" {
  count               = length(var.private_subnet_cidr)
  vpc_id              = aws_vpc.default.id
  cidr_block          = element(var.private_subnet_cidr, count.index)
  availability_zone   = element(var.azs, count.index)
  tags = {
    Name = "${var.vpc_name}-privatedsubnet-${count.index + 1}"
  }
}

