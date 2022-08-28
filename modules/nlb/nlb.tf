resource "aws_lb" "test" {
   name               =  "${var.nlbname}-nlb"
   internal           =  false
   load_balancer_type =  "network"
   subnets            =  var.subnets
   enable_deletion_protection = false
   
   tags  =  { 
     Environment  = var.environment
}
}

resource "aws_lb_target_group" "test" {
   name      =  "${var.nlbname}-nlb-tg"
   port      =  80
   protocol  = "TCP"
   vpc_id    = var.vpc_id

}

resource "aws_lb_target_group_attachment" "public_servers_attachment" {
    count               =  "${var.environment == "Prod" ? 3: 1}"
   target_group_arn     =  aws_lb_target_group.test.arn
   target_id            =  "${element(var.public_server, count.index)}"
   port                 =  80
}

resource "aws_lb_target_group_attachment" "private_servers_attachment" {
   count               =  "${var.environment  == "Prod" ? 3: 1}"
   target_group_arn    =  "aws_alb_target_group.test.arn"
   target_id           =  "${element(var.private_server, count.index)}"
   port                =  80
}

