resource "aws_route_table" "terraform_public" {
   vpc_id          = aws_vpc.default.id
   route { 
       cidr_block  = "0.0.0.0/0"
       gateway_id  = aws_internet_gateway.default.id
      }
     tags = { 
      Name  = "${var.vpc_name}=public-table}"
     }
  }

resource "aws_route_table" "terraform_private" {
 vpc_id          = aws_vpc.default.id
   route {
       cidr_block  = "0.0.0.0/0"
       gateway_id  = var.nat_id
      }
     tags = {
      Name  = "${var.vpc_name}=private-table"
     }
  }

