resource "aws_instance" "private_server" {
       count                = var.environment == "production" ? 3 : 1
#      count                = length(var.private_subnet_cidr)

       ami                  = var.imagename

#      ami                  = lookup(var.amis, var.region)
       instance_type        = var.instance_type
       key_name             = var.key_name
       subnet_id            = element(var.private_subnets, count.index)
     vpc_security_group_ids = [var.sg]
      depends_on            = [var.ngw_depends_on]
       associate_public_ip_address = true

       tags = {
            Name       = "${var.vpc_name}-privateserver-${count.index + 1}"
            Env        = "Prod"
            Owner      = "Somana"
            CostCenter = "ABCD"
}
}
