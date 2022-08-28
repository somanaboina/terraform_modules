output my_vpc_id { 
    value = "${module.dev_infra_1.vpc_id}"
   }

output my_vpc_name { 
   value  = "${module.dev_infra_1.vpc_name}"
   }

