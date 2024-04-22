output "tgw_id" {
  description = "Transit Gateway ID"
  value       = aws_ec2_transit_gateway.tgw.id
}

output "cgw_id" {
  description = "Customer Gateway ID"
  value       = { for k, v in var.vpn : k => aws_customer_gateway.tgw[k].id }
}

output "vpn_conn_id" {
  description = "VPN conneciton ID"
  value       = { for k, v in var.vpn : k => aws_vpn_connection.tgw[k].id }
}
