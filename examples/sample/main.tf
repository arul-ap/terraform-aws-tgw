terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = var.default_tags
  }
}

module "tgw" {
  source = "arul-ap/tgw/aws"
  org = "abc"
  proj = "x"
  env = "dev"
  tgw = {
    name = "tgw01"
    description = "test"
  }
  
  tgw_vpc_accepter = { /*
    vpc_attach-01 ={
    tgw_attachment_id = "" // VPC attachement ID
    tgw_default_rt_association = true
    tgw_deafult_rt_propagation = true
    } */
  }
  
   
  vpn = { /*
    vpn-01 = {
      asn = 65344
      ip_address = "1.1.1.1"
    } */
  } 
  
  // tgw_share_principal_list = ["123456789012"] // Account ID, Org ARN or OU ARN.


}
