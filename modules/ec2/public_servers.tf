resource "aws_instance" "public_server" {
       count                = var.environment == "production" ? 3 : 1
#      count                = length(var.public_subnet_cidr)

       ami                  = var.imagename

#      ami                  = lookup(var.amis, var.region)
       instance_type        = var.instance_type
       key_name             = var.key_name
       subnet_id            = element(var.public_subnets, count.index)
     vpc_security_group_ids = [var.sg]
       associate_public_ip_address = true
       iam_instance_profile = var.iam_instance_profile
       tags = { 
            Name       = "${var.vpc_name}-publicserver-${count.index + 1}"
            Env        = "Prod"
            Owner      = "Somana"
            CostCenter = "ABCD"
}
}
