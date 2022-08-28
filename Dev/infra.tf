module "dev_infra_1" {
  source              = "../modules/vpc"
  vpc_name            = "dev_infra_1_vpc"
  cidr_block          = "10.10.0.0/16"
  environment         = "development"
  private_subnet_cidr = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  public_subnet_cidr  = ["10.10.10.0/24", "10.10.20.0/24", "10.10.30.0/24"]
  azs                 = ["us-east-1a", "us-east-1b", "us-east-1c"]
#  region              = "us-east-1"
  nat_id              = "${module.dev_infra_1_nat.nat_id}"  
}

module "dev_infra_1_sg" {
  source         =  "../modules/sg"
  vpc_id         = "${module.dev_infra_1.vpc_id}"
}

module "dev_infra_1_nat" { 
   source           = "../modules/nat"
   public_subnet1   = "${module.dev_infra_1.public_subnet_list_1}"
   igw_depends_on   = "${module.dev_infra_1.igw}"
}

module "dev_infra_1_nlb" { 
     source          =  "../modules/nlb"
     subnets         = "${module.dev_infra_1.public_subnet_list}"
     environment     = "${module.dev_infra_1.environment}"
     nlbname         = "devopsb22"
     tgname          = "devopsb22"
     vpc_id          = module.dev_infra_1.vpc_id
     public_server  = module.dev_infra_1_ec2.public_server
     private_server = module.dev_infra_1_ec2.private_server
}

module "dev_infra_1_iam" { 
    source       =  "../modules/iam"
   environment   = "${module.dev_infra_1.environment}"
   rolename      = "DevopsB22Role"
   instanceprofilename = "DevopsB22Profile"
   iam_policy_name     = "DevopsB22IamPolicy"

}
module dev_infra_1_ec2 {
   source            = "../modules/ec2"
#   vpc_id            = "${module.dev_infra_1.vpc.id}"
   vpc_name          = "${module.dev_infra_1.vpc_name}"
   public_subnets    = "${module.dev_infra_1.public_subnet_list}"
   private_subnets   = "${module.dev_infra_1.private_subnet_list}"
   environment       =   "${module.dev_infra_1.environment}"
   imagename         =  "ami-05fa00d4c63e32376"
   instance_type     =   "t2.nano"
   key_name          =  "Laptopkey"
   sg                =  "${module.dev_infra_1_sg.sg}"
   ngw_depends_on   =  "${module.dev_infra_1_nat.nat_id}"
  iam_instance_profile = module.dev_infra_1_iam.instprofile
}

module dev_infra_1_route53 { 
  source    =  "../modules/route53"
  domainname = "somanaboina.xyz"
  nlb_id     = module.dev_infra_1_nlb.nlb_id
  dns_name   = module.dev_infra_1_nlb.nlb_dns_name
  zone_id    = module.dev_infra_1_nlb.nlb_zone_id
}

