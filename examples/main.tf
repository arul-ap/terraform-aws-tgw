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
  } /*
  vpn = {
    vpn1 = {
      asn = 65344
      ip_address = "1.1.1.1"
    }
  } */
   // tgw_share_principal_list = ["123456789012"]

}
