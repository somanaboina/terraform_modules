resource "aws_eip" "eip_nat" {
  tags = { 
       Name = "NAT-EIP"
   }

}

  
