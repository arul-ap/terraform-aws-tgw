
locals {
  name-prefix = lower("${var.org}-${var.proj}-${var.env}") // prefix for naming resources
}

data "aws_region" "current" {}

resource "aws_ec2_transit_gateway" "tgw" {
  description                 = var.tgw.description
  amazon_side_asn             = var.tgw.asn
  transit_gateway_cidr_blocks = var.tgw.tgw_cidr
  tags = {
    Name = "${local.name-prefix}-${var.tgw.name}"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "tgw" {
  for_each                                        = var.tgw_vpc_accepter
  transit_gateway_attachment_id                   = each.value.tgw_attachment_id
  transit_gateway_default_route_table_association = each.value.tgw_default_rt_association
  transit_gateway_default_route_table_propagation = each.value.tgw_deafult_rt_propagation
  tags = {
    Name = "${local.name-prefix}-${each.key}"
  }
}

resource "aws_customer_gateway" "tgw" {
  for_each   = var.vpn
  bgp_asn    = each.value.asn
  ip_address = each.value.ip_address
  type       = "ipsec.1"
  tags = {
    Name = "${local.name-prefix}-${each.key}-cgw"
  }
}

resource "aws_vpn_connection" "tgw" {
  for_each            = var.vpn
  transit_gateway_id  = aws_ec2_transit_gateway.tgw.id
  customer_gateway_id = aws_customer_gateway.tgw[each.key].id
  type                = "ipsec.1"
  tags = {
    Name = "${local.name-prefix}-${each.key}-vpn"
  }
}

locals {
  tgw_share = length(var.tgw_share_principal_list) == 0 ? 0 : 1
}
resource "aws_ram_resource_share" "tgw" {
  count                     = local.tgw_share
  name                      = aws_ec2_transit_gateway.tgw.id
  allow_external_principals = false
}


resource "aws_ram_resource_association" "tgw" {
  count              = local.tgw_share
  resource_arn       = aws_ec2_transit_gateway.tgw.arn
  resource_share_arn = aws_ram_resource_share.tgw[0].arn
}

resource "aws_ram_principal_association" "tgw" {
  count              = length(var.tgw_share_principal_list)
  resource_share_arn = aws_ram_resource_share.tgw[0].arn
  principal          = var.tgw_share_principal_list[count.index]
}

