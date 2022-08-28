
output public_server { 
   value  =  aws_instance.public_server.*.id
   }
output private_server { 
   value  =  aws_instance.private_server.*.id
   }

