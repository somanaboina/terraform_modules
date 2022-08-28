resource "aws_nat_gateway" "devopsb22-nat" {
   allocation_id    = aws_eip.eip_nat.id
   subnet_id        = var.public_subnet1


   tags  = {
     Name  = "DevopsB22-IGW"
}

   depends_on  = [var.igw_depends_on]
}

